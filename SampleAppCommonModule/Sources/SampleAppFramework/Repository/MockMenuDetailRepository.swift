//
//  MockMenuDetailRepository.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Foundation
import SampleAppDomain

public struct MockMenuDetailRepository: MenuDetailRepositoryProtocol {
    public static func fetch(menu: SampleAppDomain.Menu) async throws -> String {
        "\(menu.name) の詳細...（モック）"
    }
}
