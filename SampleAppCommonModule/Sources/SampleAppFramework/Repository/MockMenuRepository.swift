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
    var menus: [Menu]
    var isFetchFailure: Bool

    public init(menus: [Menu] = .stub(), isFetchFailure: Bool = false) {
        self.menus = menus
        self.isFetchFailure = isFetchFailure
    }

    public func fetch() async throws -> [Menu] {
        guard !isFetchFailure else {
            throw MockError()
        }
        return menus
    }
}
