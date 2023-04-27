//
//  HomeView.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @StateObject var homePresenter: HomePresenter

    var body: some View {
        NavigationStack {
            Spacer()

            Button(action: { homePresenter.pushButtonTapped() }) {
                Text("Push 遷移する")
            }
            .navigationDestination(isPresented: $homePresenter.isPresentedPush) {
                Text("Push 遷移先の画面")
            }

            Spacer()

            Button(action: { homePresenter.modalButtonTapped() }) {
                Text("Modal を表示する")
            }
            .sheet(isPresented: $homePresenter.isPresentedModal) {
                HomeSubView()
            }

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homePresenter: HomePresenter())
    }
}
