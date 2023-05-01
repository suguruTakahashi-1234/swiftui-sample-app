//
//  MenuDetailView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SampleAppDomain
import SampleAppFramework
import SwiftUI

struct MenuDetailView<Repository: MenuDetailRepositoryProtocol>: View {
    @StateObject var menuDetailPresenter: MenuDetailPresenter<Repository>

    var body: some View {
        Text(menuDetailPresenter.menuDetail)
            .task {
                await menuDetailPresenter.onAppear()
            }
            .alert("", isPresented: $menuDetailPresenter.isShowingAlert) {
                Button("") {}
            } message: {
                Text(menuDetailPresenter.errorMessage)
            }
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let menuDetailRepository = MenuDetailRepositoryProtocolMock()
        menuDetailRepository.fetchHandler = { _ in "適当な文字列" }

        return VStack {
            MenuDetailView(menuDetailPresenter: MenuDetailPresenter(menu: .stub(), repository: menuDetailRepository))
        }
    }
}
