//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation
import SampleAppDomain

public struct MenuRepository: MenuRepositoryProtocol {
    public init() {}

    public func fetch() async throws -> [Menu] {
        [Menu(name: "tea"), Menu(name: "coffee")]
    }
}
