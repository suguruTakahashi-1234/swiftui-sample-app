//
//  MenuPresenter.swift
//
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import Foundation
import SampleAppDomain
import SampleAppFramework

class MenuPresenter: ObservableObject {
    private let menuRepository: MenuRepositoryProtocol

    @Published var isPresented: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published private(set) var menus: [Menu] = []
    private(set) var errorMessage: String = ""

    init(menuRepository: MenuRepositoryProtocol = MenuRepository()) {
        self.menuRepository = menuRepository
    }

    @MainActor
    func onAppear() async {
        do {
            menus = try await menuRepository.fetch()
        } catch {
            errorMessage = error.localizedDescription
            isShowingAlert = true
        }
    }
}
