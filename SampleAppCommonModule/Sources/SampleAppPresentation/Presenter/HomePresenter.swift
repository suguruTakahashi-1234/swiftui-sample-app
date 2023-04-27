//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation

@MainActor
class HomePresenter: ObservableObject {
    @Published var isPresentedPush: Bool = false
    @Published var isPresentedModal: Bool = false

    func pushButtonTapped() {
        isPresentedPush = true
    }

    func modalButtonTapped() {
        isPresentedModal = true
    }
}
