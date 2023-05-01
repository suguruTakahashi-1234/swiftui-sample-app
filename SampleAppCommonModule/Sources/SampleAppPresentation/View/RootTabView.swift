//
//  RootTabView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import SampleAppCoreUI
import SwiftUI

extension RootTabType: Identifiable {
    public var id: String {
        tabName
    }

    var tabName: String {
        switch self {
        case .home:
            return "home"
        case .order:
            return "order"
        case .setting:
            return "setting"
        }
    }

    var image: Image {
        switch self {
        case .home:
            return Image(systemName: "house")
        case .order:
            return Image(systemName: "cup.and.saucer")
        case .setting:
            return Image(systemName: "gearshape")
        }
    }

    var text: Text {
        Text(tabName)
    }

    @MainActor
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .home:
            HomeView(homePresenter: HomePresenter())
        case .order:
            OrderView(orderPresenter: OrderPresenter())
        case .setting:
            SettingView()
        }
    }
}

public struct RootTabView: View {
    @StateObject var rootTabPresenter: RootTabPresenter

    // SwiftUI の Previews で各タブを選択しているパターンを確認するために
    // イニシャライザで rootTabPresenter の初期化を行なっている。（結合テストの責務？）
    // 正直、今の実装はやりすぎかもしれない。View 側で RootTabType の指定が不要であれば、
    // RootTabPresenter 側でも RootTabType を引数として取る必要はない。
    public init(selectedTabType: RootTabType = .home) {
        _rootTabPresenter = StateObject(wrappedValue: RootTabPresenter(selectedTabType: selectedTabType))
    }

    public var body: some View {
        TabView(selection: $rootTabPresenter.selectedTabType) {
            ForEach(RootTabType.allCases) { tabType in
                tabType.contentView
                    .tabItem {
                        tabType.image
                        tabType.text
                    }
                    .tag(tabType)
            }
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RootTabView()
            RootTabView(selectedTabType: .home)
        }
    }
}
