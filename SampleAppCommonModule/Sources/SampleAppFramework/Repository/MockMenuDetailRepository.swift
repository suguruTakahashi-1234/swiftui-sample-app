//
//  MockMenuDetailRepository.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Foundation
import SampleAppDomain

public struct MockMenuDetailRepository: MenuDetailRepositoryProtocol {
    var detail: String

    public init(detail: String = "モックから好きな紹介文が設定できます") {
        self.detail = detail
    }

    public func fetch(menu: SampleAppDomain.Menu) async throws -> String {
        "\(menu.name) \(detail)"
    }
}
