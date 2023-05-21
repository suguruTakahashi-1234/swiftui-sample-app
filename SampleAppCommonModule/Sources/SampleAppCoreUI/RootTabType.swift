//
//  RootTabType.swift
//
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import Foundation

public enum RootTabType {
    case login
    case web
    case order
    case setting
    case debug
}

extension RootTabType: Equatable, CaseIterable {}
