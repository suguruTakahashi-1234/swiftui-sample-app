//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Foundation
import SampleAppDomain

// MenuPresenterではRepositoryの保持をしているが、型パラメーターを指定してあげると Presenter 側でのRepositoryの保持が不要になる
//   -> すると Repository の処理は static func で定義できる
//   -> また、dynamic dispatch ではなく、static dispatch となるので、ビルドが処理が早い
//     -> Ref: https://www.youtube.com/watch?v=HygLwTRO-Zw
//   -> ただし、initの引数で渡すときに可能であったRepositoryの隠蔽はできなくなる
//   -> また、static func で定義してしまうと、Mockのように外から値を自由に変えれるようにできなくなってしまう
@MainActor
class MenuDetailPresenter<Repository: MenuDetailRepositoryProtocol>: ObservableObject {
    @Published private(set) var menuDetail: String = ""
    private let menu: SampleAppDomain.Menu

    init(menu: SampleAppDomain.Menu) {
        self.menu = menu
    }
    
    func onAppear() async {
        menuDetail = try! await Repository.fetch(menu: menu)
    }
}
