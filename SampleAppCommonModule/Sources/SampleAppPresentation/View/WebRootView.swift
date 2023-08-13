//
//  WebRootView.swift
//
//
//  Created by Suguru Takahashi on 2023/05/20.
//

import SwiftUI
import WebKit

struct WebRootView: View {
    @State var shouldShowModal: Bool = false

    var body: some View {
        NavigationView {
            Button {
                shouldShowModal = true
            } label: {
                Text("hoge")
            }
        }
        .fullScreenCover(isPresented: $shouldShowModal) {
            WebTopView()
        }
    }
}
