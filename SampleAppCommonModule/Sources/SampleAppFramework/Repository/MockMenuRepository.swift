//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation
import SampleAppCoreFoundation
import SampleAppDomain

public struct MockMenuRepository: MenuRepositoryProtocol {
    var menus: [String]
    var isFetchFailure: Bool

    public init(menus: [String] = ["好きなモックデータを指定できる"], isFetchFailure: Bool = false) {
        self.menus = menus
        self.isFetchFailure = isFetchFailure
    }

    public func fetch() async throws -> [String] {
        guard !isFetchFailure else {
            throw MockError()
        }
        return menus
    }
}
