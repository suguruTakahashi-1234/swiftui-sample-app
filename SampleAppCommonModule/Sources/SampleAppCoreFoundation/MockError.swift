//
//  MockError.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation

public enum MockError: Error {
    case mockError
}

extension MockError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .mockError:
            return "Mock Error"
        }
    }
}
