//
//  WebRootView.swift
//
//
//  Created by Suguru Takahashi on 2023/05/20.
//

import SwiftUI
import WebKit

struct WebRootView: View {
    @ObservedObject var webViewPresenter = WebViewPresenter()

    var body: some View {
        NavigationView {
            ZStack {
                WebView(presenter: webViewPresenter, url: URL(string: "https://www.spacemarket.com/features/bbq/")!)
                if webViewPresenter.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(leading: Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .disabled(!webViewPresenter.canGoBack)
            }, trailing: Button(action: goForward) {
                Image(systemName: "chevron.right")
                    .disabled(!webViewPresenter.canGoForward)
            })
        }
        .alert(isPresented: $webViewPresenter.showAlert) {
            Alert(
                title: Text("注意"),
                message: Text("他のアプリに遷移しますがよろしいでしょうか？"),
                primaryButton: .default(Text("はい"), action: webViewPresenter.handleOpenURL),
                secondaryButton: .default(Text("いいえ"), action: { webViewPresenter.pendingURL = nil })
            )
        }
    }

    func goBack() {
        webViewPresenter.webView.goBack()
    }

    func goForward() {
        webViewPresenter.webView.goForward()
    }
}
