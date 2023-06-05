//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/04.
//

import SampleAppCoreUI
import SwiftUI

struct LoadingNextView: View {
    @StateObject private var presenter = LoadingNextPresenter()

    var body: some View {
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
        }
    }
}
