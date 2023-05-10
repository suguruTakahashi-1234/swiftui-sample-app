//
//  MenuRepositoryStub.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation
import SampleAppCoreFoundation
import SampleAppDomain

// Mockolo で自動生成した MenuRepositoryProtocolMock と役割が重複するのでどちらか一方のみで良さそう
// 初期化時に色々設定できるのでこちらのstructでもよいが、Mockolo で自動生成したものを使ったほうがメンテが楽である
public struct MenuRepositoryStub: MenuRepositoryProtocol {
    var menus: [Menu]
    var isFetchFailure: Bool

    public init(menus: [Menu] = .stub(), isFetchFailure: Bool = false) {
        self.menus = menus
        self.isFetchFailure = isFetchFailure
    }

    public func fetch() async throws -> [Menu] {
        guard !isFetchFailure else {
            throw MockError.mockError
        }
        return menus
    }
}
