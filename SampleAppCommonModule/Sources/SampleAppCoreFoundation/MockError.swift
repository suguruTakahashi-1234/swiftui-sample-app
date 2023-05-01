//
//  MockError.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation

public struct MockError: Error, LocalizedError {
    public init() {}

    public var errorDescription: String? {
        "MockError"
    }
}
