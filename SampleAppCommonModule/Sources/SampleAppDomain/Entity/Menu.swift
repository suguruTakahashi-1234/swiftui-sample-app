//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/28.
//

import Foundation

public struct Menu: Identifiable, Hashable {
    public let id: String = UUID().uuidString
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

// 以下のような便利なテストデータ生成系はどこに置くかはまた検討する
public extension Menu {
    static func stub(neme: String = "stub name") -> Menu {
        Menu(name: neme)
    }
}

public extension [Menu] {
    static func stub() -> [Menu] {
        [.stub(neme: "stub 1"), .stub(neme: "stub 2"), .stub(neme: "stub 3")]
    }
}
