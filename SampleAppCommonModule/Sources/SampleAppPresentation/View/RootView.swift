//
//  RootView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import SwiftUI

public struct RootView: View {
    @StateObject private var loadingStatePresenter = LoadingStatePresenter()

    public init() {}

    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                RootTabView()
                    .navigationTitle("Smaple App")
                    .overlayLoading(isPresented: $loadingStatePresenter.isLoading, allowsGesture: $loadingStatePresenter.allowsGesture)
            }
        } else {
            NavigationView {
                RootTabView()
                    .navigationTitle("Smaple App")
                    .overlayLoading(isPresented: $loadingStatePresenter.isLoading, allowsGesture: $loadingStatePresenter.allowsGesture)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
