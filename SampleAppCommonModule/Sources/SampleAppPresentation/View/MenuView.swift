//
//  MenuView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SampleAppCoreFoundation
import SampleAppDomain
import SampleAppFramework
import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var menuPresenter: MenuPresenter

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List(menuPresenter.menus, id: \.self.id) { menu in
                    NavigationLink(value: menu) {
                        Text(menu.name)
                    }
                }
                .navigationDestination(for: Menu.self) { menu in
                    // Presenter側でrepositoryの型指定しているためrepositoryの省略が不可になっている
                    MenuDetailView(menuDetailPresenter: MenuDetailPresenter(menu: menu, repository: MenuDetailRepository()))
                }
            }
            .task {
                await menuPresenter.onAppear()
            }
            .alert("エラータイトル", isPresented: $menuPresenter.isShowingAlert) {
                Button("アラートの完了ボタン") {
                    // NavigationStack のエラーがでています🙏
                    dismiss()
                }
            } message: {
                Text(menuPresenter.errorMessage)
            }
        } else {
            // TODO: 修正する
            EmptyView()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let menuRepository = MenuRepositoryProtocolMock()
        menuRepository.fetchHandler = { .stub() }
        
        let errorMenuRepository = MenuRepositoryProtocolMock()
        errorMenuRepository.fetchHandler = { throw MockError() }

        return VStack {
            MenuView(menuPresenter: MenuPresenter(menuRepository: menuRepository))
            MenuView(menuPresenter: MenuPresenter(menuRepository: errorMenuRepository))
        }
    }
}
