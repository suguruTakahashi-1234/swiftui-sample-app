//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/04.
//

import SampleAppCoreUI
import SwiftUI

struct LoadingTopView: View {
    @StateObject private var loadingStatePresenter = LoadingStatePresenter()
    @StateObject private var presenter = LoadingTopPresenter()

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    presenter.startLoading()
                }) {
                    Text("Start Loading")
                }
                Button(action: {
                    presenter.stopLoading()
                }) {
                    Text("Stop Loading")
                }
                NavigationLink(destination: LoadingNextView()) {
                    Text("Go to Another View")
                }
            }
        }
        .overlayLoading(isPresented: $loadingStatePresenter.isLoading, allowsGesture: $loadingStatePresenter.allowsGesture)
    }
}
