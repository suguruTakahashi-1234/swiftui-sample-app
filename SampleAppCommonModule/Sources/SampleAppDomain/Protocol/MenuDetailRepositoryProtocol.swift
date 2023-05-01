//
//  MenuDetailRepositoryProtocol.swift
//
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Foundation

/// @mockable
public protocol MenuDetailRepositoryProtocol {
    func fetch(menu: SampleAppDomain.Menu) async throws -> String
}
