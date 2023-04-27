//
//  MenuView.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SwiftUI
import SampleAppFramework

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var menuPresenter: MenuPresenter

    var body: some View {
        NavigationStack {
            List(menuPresenter.menus, id: \.self) { menu in
                NavigationLink(value: menu) {
                    Text(menu)
                }
            }
            .navigationDestination(for: String.self) { value in
                Text(value)
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
            MenuView(menuPresenter: MenuPresenter(menuRepository: MockMenuRepository(
                menus: ["好きな", "モックデータ", "を", "指定できる"]))
            )
            MenuView(menuPresenter: MenuPresenter(menuRepository: MockMenuRepository(isFetchFailure: true)))
        }
    }
}
