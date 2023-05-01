//
//  MenuView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

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
                    // 本番データの場合
                    MenuDetailView(menuDetailPresenter: MenuDetailPresenter(menu: menu, repository: MenuDetailRepository()))
                    
                    // スタブの場合
                    MenuDetailView(menuDetailPresenter: MenuDetailPresenter(menu: menu, repository: MenuDetailRepositoryStub(detail: "スタブから自由な値を設定してみた")))
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
        VStack {
            MenuView(menuPresenter: MenuPresenter(menuRepository: MenuRepository()))
            MenuView(menuPresenter: MenuPresenter(menuRepository: MenuRepositoryStub()))
            MenuView(menuPresenter: MenuPresenter(menuRepository: MenuRepositoryStub(menus: [Menu(name: "好きな値を設定できる")])))
            MenuView(menuPresenter: MenuPresenter(menuRepository: MenuRepositoryStub(isFetchFailure: true)))
        }
    }
}
