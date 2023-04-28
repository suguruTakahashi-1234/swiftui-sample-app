//
//  MenuDetailView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SwiftUI
import SampleAppDomain
import SampleAppFramework

struct MenuDetailView<Repository: MenuDetailRepositoryProtocol>: View {
    @StateObject var menuDetailPresenter: MenuDetailPresenter<Repository>

    var body: some View {
        Text(menuDetailPresenter.menuDetail)
            .task {
                await menuDetailPresenter.onAppear()
            }
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MenuDetailView<MenuDetailRepository>(menuDetailPresenter: MenuDetailPresenter(menu: .stub(neme: "hoge")))
            MenuDetailView<MenuDetailRepository>(menuDetailPresenter: MenuDetailPresenter(menu: .stub(neme: "moge")))
        }
    }
}
