//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/05.
//

import Combine
import SampleAppDomain
import SampleAppFramework

class LoadingStatePresenter: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var allowsGesture: Bool = true

    private var appState: AppStateProtocol

    init(appState: AppStateProtocol = AppState.shared) {
        self.appState = appState

        Publishers
            .CombineLatest3(self.appState.isLoadingCommon, self.appState.isLoadingTop, self.appState.isLoadingNext)
            .map { $0 || $1 || $2 }
            .assign(to: &$isLoading)

        self.appState.isLoadingNext
            .map { !$0 }
            .assign(to: &$allowsGesture)
    }
}
