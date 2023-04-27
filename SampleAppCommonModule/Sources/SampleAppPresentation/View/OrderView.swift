//
//  OrderView.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SwiftUI
import SampleAppFramework

struct OrderView: View {
    @ObservedObject var orderPresenter: OrderPresenter

    var body: some View {
        NavigationStack {
            Spacer()

            Button(action: { orderPresenter.menuButtonTapped() }) {
                Text("メニューを表示する")
            }
            .sheet(isPresented: $orderPresenter.isPresentedMenu) {
                MenuView(menuPresenter: MenuPresenter())
            }

            Spacer()

            Button(action: { orderPresenter.mockMenuButtonTapped1() }) {
                Text("モックデータのメニューを表示する その1")
            }
            .sheet(isPresented: $orderPresenter.isPresentedMockMenu1) {
                MenuView(menuPresenter: MenuPresenter(menuRepository: MockMenuRepository()))
            }

            Spacer()

            Button(action: { orderPresenter.mockMenuButtonTapped2() }) {
                Text("モックデータのメニューを表示する その2")
            }
            .sheet(isPresented: $orderPresenter.isPresentedMockMenu2) {
                MenuView(
                    menuPresenter: MenuPresenter(
                        menuRepository: MockMenuRepository(menus: ["好きな", "モックデータ", "を", "指定できる"])
                    )
                )
            }

            Spacer()

            Button(action: { orderPresenter.mockMenuButtonTapped3() }) {
                Text("モックデータのメニューを表示する その3 \nエラー系")
            }
            .sheet(isPresented: $orderPresenter.isPresentedMockMenu3) {
                MenuView(
                    menuPresenter: MenuPresenter(
                        menuRepository: MockMenuRepository(isFetchFailure: true)
                    )
                )
            }

            Spacer()
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(orderPresenter: OrderPresenter())
    }
}
