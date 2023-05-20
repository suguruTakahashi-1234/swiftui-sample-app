//
//  WebView.swift
//
//
//  Created by Suguru Takahashi on 2023/05/20.
//

import SwiftUI
import WebKit

class WebViewPresenter: ObservableObject {
    let webView: WKWebView = .init()
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var showAlert: Bool = false
    @Published var pendingURL: URL? = nil

    func handleOpenURL() {
        guard let url = pendingURL else {
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        pendingURL = nil
    }
}

struct WebView: UIViewRepresentable {
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

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
}

class WebViewCoordinator: NSObject {
    var parent: WebView

    init(_ parent: WebView) {
        self.parent = parent
    }
}

extension WebViewCoordinator: WKNavigationDelegate {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        parent.presenter.isLoading = true
    }

    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        parent.presenter.isLoading = false
        parent.presenter.canGoBack = webView.canGoBack
        parent.presenter.canGoForward = webView.canGoForward
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        parent.presenter.isLoading = false
    }

    func webView(_: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError _: Error) {
        parent.presenter.isLoading = false
    }

    func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
              let urlScheme = url.scheme?.lowercased(),
              let urlHost = url.host?.lowercased()
        else {
            decisionHandler(.allow)
            return
        }

        // WebView内で遷移せずに処理されるスキーム
        // - http, https: 通常のウェブページを指すスキーム
        // - about: 特殊なページを指すスキーム ex) about:blank
        // - javascript: ブラウザ内でJavaScriptコードを実行するためのスキーム
        // - data: インラインデータを指すスキーム
        // - blob: ブラウザ内に生成された大きなデータオブジェクトを指すスキーム
        // - file: ローカルファイルシステム上のファイルを指すスキーム
        let nonTransitioningSchemes = ["http", "https", "about", "data", "blob", "file"]

        if !nonTransitioningSchemes.contains(urlScheme) || urlHost.contains("apps.apple.com") {
            print(url)
            parent.presenter.pendingURL = url
            parent.presenter.showAlert = true
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

extension WebViewCoordinator: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith _: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures _: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            // 新規にタブを作成するようなリンクをタップした場合はWebViewのデフォルトでは何も起きないため、新規タブを開かずにそのView内でページを更新するようにする
            webView.load(navigationAction.request)
        }
        return nil
    }
}
