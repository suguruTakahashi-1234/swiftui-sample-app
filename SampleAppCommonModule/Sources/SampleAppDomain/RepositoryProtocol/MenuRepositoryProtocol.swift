//
//  MenuRepositoryProtocol.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation

/// @mockable
public protocol MenuRepositoryProtocol {
    func fetch() async throws -> [Menu]
}
