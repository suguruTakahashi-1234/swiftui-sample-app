//
//  MenuView.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SwiftUI
import SampleAppDomain
import SampleAppFramework

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var menuPresenter: MenuPresenter

    var body: some View {
        NavigationStack {
            List(menuPresenter.menus, id: \.self.id) { menu in
                NavigationLink(value: menu) {
                    Text(menu.name)
                }
            }
            .navigationDestination(for: Menu.self) { menu in
                // 本番データが欲しい場合
                MenuDetailView<MenuDetailRepository>(menuDetailPresenter: MenuDetailPresenter(menu: menu))

                // スタブデータが欲しい場合
                MenuDetailView<MockMenuDetailRepository>(menuDetailPresenter: MenuDetailPresenter(menu: menu))
            }
        }
        .task {
            await menuPresenter.onAppear()
        }
        .alert("エラータイトル", isPresented: $menuPresenter.isShowingAlert) {
            Button("アラートの完了ボタン") {
                print(menuPresenter.errorMessage)
                dismiss()
            }
        } message: {
            Text(menuPresenter.errorMessage)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MenuView(menuPresenter: MenuPresenter(menuRepository: MenuRepository()))
            MenuView(menuPresenter: MenuPresenter(menuRepository: MockMenuRepository()))
            MenuView(menuPresenter: MenuPresenter(menuRepository: MockMenuRepository(menus: [Menu(name: "好きな値を設定できる")])))
            MenuView(menuPresenter: MenuPresenter(menuRepository: MockMenuRepository(isFetchFailure: true)))
        }
    }
}
