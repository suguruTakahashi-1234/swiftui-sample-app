//
//  MenuDetailView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SampleAppCoreFoundation
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
            .alert("アラートタイトル", isPresented: $menuDetailPresenter.isShowingAlert) {
                Button("OK") {}
            } message: {
                Text(menuDetailPresenter.errorMessage)
            }
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let menuDetailRepository = MenuDetailRepositoryProtocolMock()
        menuDetailRepository.fetchHandler = { _ in "適当な文字列" }

        let errorMenuDetailRepository = MenuDetailRepositoryProtocolMock()
        errorMenuDetailRepository.fetchHandler = { _ in throw MockError() }

        return VStack {
            MenuDetailView(menuDetailPresenter: MenuDetailPresenter(menu: .stub(), repository: menuDetailRepository))
            MenuDetailView(menuDetailPresenter: MenuDetailPresenter(menu: .stub(), repository: errorMenuDetailRepository))
        }
    }
}
