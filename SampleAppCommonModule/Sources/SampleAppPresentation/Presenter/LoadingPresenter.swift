//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/04.
//

import Combine
import SampleAppDomain
import SampleAppFramework

@MainActor
class LoadingTopPresenter: ObservableObject {
    private var appState: AppStateProtocol

    init(appState: AppStateProtocol = AppState.shared) {
        self.appState = appState
    }

    func startLoading() {
        appState.isLoadingTop.send(true)
    }

    func stopLoading() {
        appState.isLoadingTop.send(false)
    }

    deinit {
        appState.isLoadingTop.send(false)
    }
}

@MainActor
class LoadingNextPresenter: ObservableObject {
    private var appState: AppStateProtocol

    init(appState: AppStateProtocol = AppState.shared) {
        self.appState = appState
    }

    func startLoading() {
        appState.isLoadingNext.send(true)
    }

    func stopLoading() {
        appState.isLoadingNext.send(false)
    }

    deinit {
        // よくないらしいので修正する（本来はタスクハンドラーのonキャンセルを定義してそれを実行する）
        appState.isLoadingNext.send(false) // Publishing changes from within view updates is not allowed, this will cause undefined behavior.
    }
}
