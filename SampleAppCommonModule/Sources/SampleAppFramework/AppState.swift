//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/04.
//

import Combine
import SampleAppDomain

public class AppState: AppStateProtocol {
    public static let shared = AppState()

    public var isLoadingCommon = CurrentValueSubject<Bool, Never>(false)
    public var isLoadingTop = CurrentValueSubject<Bool, Never>(false)
    public var isLoadingNext = CurrentValueSubject<Bool, Never>(false)

    private init() {}
}
