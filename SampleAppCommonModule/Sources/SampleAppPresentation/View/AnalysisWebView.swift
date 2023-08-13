//
//  WebView.swift
//
//
//  Created by Suguru Takahashi on 2023/05/20.
//

import Combine
import SwiftUI
import WebKit

@MainActor
class WebViewPresenter: ObservableObject {
    let webView: WKWebView = .init()
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var shouldShowAccessControlAlert = false
    @Published var isReadyToSessionStart = false
    var accessControlList: [String] = []
    var scrollOffset = CGPoint(x: 0.0, y: 0.0) // nil ではなく x: 0.0, y: 0.0 で正しい

    var webViewGeometrySize: CGSize?
    var webViewGeometryFrameInGlobalMinX: CGFloat?
    var webViewGeometryFrameInGlobalMinY: CGFloat?

    @Published var relativePoint: CGPoint? // デバイス上のポイントをWebView内部の相対座標に変換したもの
    private var gazeDevicePointPublisher: AnyPublisher<CGPoint, Never> {
        Just(.init()).eraseToAnyPublisher() // TODO: 適当
    }

    private var cancellableSet = Set<AnyCancellable>()

    init() {
        gazeDevicePointPublisher
            .compactMap { [weak self] gazeDevicePoint in
                guard let webViewGeometrySize = self?.webViewGeometrySize,
                      let webViewGeometryFrameInGlobalMinX = self?.webViewGeometryFrameInGlobalMinX,
                      let webViewGeometryFrameInGlobalMinY = self?.webViewGeometryFrameInGlobalMinY,
                      let scrollOffset = self?.scrollOffset,
                      webViewGeometrySize.width > 0,
                      webViewGeometrySize.height > 0
                else {
                    print("まだだよー")
                    return nil
                }
                let relativeX = (gazeDevicePoint.x - webViewGeometryFrameInGlobalMinX + scrollOffset.x) / webViewGeometrySize.width
                let relativeY = (gazeDevicePoint.y - webViewGeometryFrameInGlobalMinY + scrollOffset.y) / webViewGeometrySize.height

                let isInsideOfScreen: Bool = gazeDevicePoint.x >= webViewGeometryFrameInGlobalMinX && gazeDevicePoint.y >= webViewGeometryFrameInGlobalMinY
                print(isInsideOfScreen)
                return CGPoint(x: relativeX, y: relativeY)
            }
            .sink { [weak self] relativePoint in
                self?.relativePoint = relativePoint
            }
            .store(in: &cancellableSet)
    }

    deinit {}

    func onAppear() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        isReadyToSessionStart = true
    }

    func updateWebViewGeometry(size: CGSize, FrameInGlobalMinX: CGFloat, FrameInGlobalMinY: CGFloat) {
        print("WebViewGeometry width: \(size.width), WebViewGeometry height: \(size.height)")
        print("webViewGeometryFrameInGlobalMinX: \(FrameInGlobalMinX)")
        print("webViewGeometryFrameInGlobalMinY: \(FrameInGlobalMinY)")
        webViewGeometrySize = size
        webViewGeometryFrameInGlobalMinX = FrameInGlobalMinX
        webViewGeometryFrameInGlobalMinY = FrameInGlobalMinY
    }

    func goBackButtonTapped() {
        webView.goBack()
    }

    func goForwardButtonTapped() {
        webView.goForward()
    }

    func reloadButtonTapped() {
        webView.reload()
    }

    func sessionStartButtonTapped() {
        print("sessionStart")
    }

    func sessionEndedButtonTapped() {
        print("sessionEnded")
    }
}

struct AnalysisWebView: UIViewRepresentable {
    @ObservedObject var presenter: WebViewPresenter
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = presenter.webView
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.load(URLRequest(url: url))

        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}

    func makeCoordinator() -> AnalysisWebViewCoordinator {
        AnalysisWebViewCoordinator(self)
    }
}

class AnalysisWebViewCoordinator: NSObject {
    var parent: AnalysisWebView

    init(_ parent: AnalysisWebView) {
        self.parent = parent
    }
}

extension AnalysisWebViewCoordinator: WKNavigationDelegate {
    @MainActor
    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        parent.presenter.canGoBack = webView.canGoBack
        parent.presenter.canGoForward = webView.canGoForward
    }

    @MainActor
    func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        guard let url = navigationAction.request.url,
              let urlScheme = url.scheme?.lowercased(),
              let urlHost = url.host?.lowercased()
        else {
            return .cancel
        }

        return .allow
    }
}

extension AnalysisWebViewCoordinator: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith _: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures _: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            // 新規にタブを作成するようなリンクをタップした場合はWebViewのデフォルトでは何も起きないため、新規タブを開かずにそのView内でページを更新するようにする
            webView.load(navigationAction.request)
        }
        return nil
    }
}
