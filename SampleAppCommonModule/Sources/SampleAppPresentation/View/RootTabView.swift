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
        case .login:
            return "login"
        case .web:
            return "web"
        case .order:
            return "order"
        case .setting:
            return "setting"
        case .debug:
            return "debug"
        }
    }

    var image: Image {
        switch self {
        case .login:
            return Image(systemName: "person")
        case .web:
            return Image(systemName: "globe.americas")
        case .order:
            return Image(systemName: "cup.and.saucer")
        case .setting:
            return Image(systemName: "gearshape")
        case .debug:
            return Image(systemName: "wrench.and.screwdriver")
        }
    }

    var text: Text {
        Text(tabName)
    }

    @ViewBuilder
    var contentView: some View {
        switch self {
        case .login:
            LoginView()
        case .web:
            WebRootView()
        case .order:
            OrderView(orderPresenter: OrderPresenter())
        case .setting:
            SettingView()
        case .debug:
            DebugRootView()
        }
    }
}

public struct RootTabView: View {
    @StateObject var rootTabPresenter: RootTabPresenter

    // SwiftUI の Previews で各タブを選択しているパターンを確認するために
    // イニシャライザで rootTabPresenter の初期化を行なっている。（結合テストの責務？）
    // 正直、今の実装はやりすぎかもしれない。View 側で RootTabType の指定が不要であれば、
    // RootTabPresenter 側でも RootTabType を引数として取る必要はない。
    public init(selectedTabType: RootTabType = .debug) {
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
            RootTabView(selectedTabType: .debug)
        }
    }
}
