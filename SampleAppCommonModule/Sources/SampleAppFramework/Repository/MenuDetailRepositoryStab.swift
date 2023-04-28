//
//  MockMenuDetailRepository.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Foundation
import SampleAppDomain

public struct MenuDetailRepositoryStab: MenuDetailRepositoryProtocol {
    var detail: String

    public init(detail: String = "スタブから好きな紹介文が設定できます") {
        self.detail = detail
    }

    public func fetch(menu: SampleAppDomain.Menu) async throws -> String {
        "\(menu.name) \(detail)"
    }
}
