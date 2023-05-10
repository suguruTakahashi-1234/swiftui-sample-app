//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import Foundation

public struct AuthResult {
    public let uid: String
    public let displayName: String?
    public let email: String?

    public init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.displayName = displayName
        self.email = email
    }
}

public struct Hoge {
    public var moge: String
    public let fuga: String

    public init(moge: String, fuga: String) {
        self.moge = moge
        self.fuga = fuga
    }
}
