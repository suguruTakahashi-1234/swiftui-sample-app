//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/04.
//

import Combine

public protocol AppStateProtocol: AnyObject {
    var isLoadingCommon: CurrentValueSubject<Bool, Never> { get }
    var isLoadingTop: CurrentValueSubject<Bool, Never> { get }
    var isLoadingNext: CurrentValueSubject<Bool, Never> { get }
}
