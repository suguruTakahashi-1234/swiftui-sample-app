//
//  CloudFileManagerProtocol.swift
//
//
//  Created by Suguru Takahashi on 2023/05/11.
//

import Foundation

/// @mockable
public protocol CloudFileManagerProtocol {
    func uploadCSVFile() async throws
}
