//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation

@MainActor
class OrderPresenter: ObservableObject {
    @Published var isPresentedMenu: Bool = false
    @Published var isPresentedMockMenu1: Bool = false
    @Published var isPresentedMockMenu2: Bool = false
    @Published var isPresentedMockMenu3: Bool = false

    func menuButtonTapped() {
        isPresentedMenu = true
    }

    func mockMenuButtonTapped1() {
        isPresentedMockMenu1 = true
    }

    func mockMenuButtonTapped2() {
        isPresentedMockMenu2 = true
    }

    func mockMenuButtonTapped3() {
        isPresentedMockMenu3 = true
    }
}
