//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/07/12.
//

import SwiftUI

struct WebTopView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var presenter = WebViewPresenter()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    AnalysisWebView(presenter: presenter, url: URL(string: "https://www.google.com/")!)
                        .onChange(of: presenter.isReadyToSessionStart) { isReadyToSessionStart in
                            if isReadyToSessionStart {
                                presenter.updateWebViewGeometry(size: geometry.size, FrameInGlobalMinX: geometry.frame(in: .global).minX, FrameInGlobalMinY: geometry.frame(in: .global).minY)
                            }
                        }

                    VStack {
                        Text("width: \(Int(geometry.size.width)), height: \(Int(geometry.size.height))")

//                        Text("global X: \(Int(geometry.frame(in: .global).origin.x))")
//                        Text("global Y: \(Int(geometry.frame(in: .global).origin.y))")

                        Text("global minX: \(Int(geometry.frame(in: .global).minX))")
                        // Text("global midX: \(Int(geometry.frame(in: .global).midX))")
                        Text("global maxX: \(Int(geometry.frame(in: .global).maxX))")

                        Text("global minY: \(Int(geometry.frame(in: .global).minY))")
                        // Text("global midY: \(Int(geometry.frame(in: .global).midY))")
                        Text("global maxY: \(Int(geometry.frame(in: .global).maxY))")
                    }
                    .background(Color.white)
                    .border(Color.black)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            presenter.goBackButtonTapped()
                        } label: {
                            Image(systemName: "chevron.left")
                                .disabled(!presenter.canGoBack)
                        }
                        Button {
                            presenter.goForwardButtonTapped()
                        } label: {
                            Image(systemName: "chevron.right")
                                .disabled(!presenter.canGoForward)
                        }
                        Button {
                            presenter.reloadButtonTapped()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                        Spacer()
                        Button {
                            presenter.sessionEndedButtonTapped()
                            dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
            }
        }
        .alert(isPresented: $presenter.shouldShowAccessControlAlert) {
            Alert(
                title: Text("注意"),
                message: Text("他のアプリに遷移しますがよろしいでしょうか？"),
                primaryButton: .default(Text("はい")),
                secondaryButton: .default(Text("いいえ"))
            )
        }
        .task {
            await presenter.onAppear()
        }
    }
}
