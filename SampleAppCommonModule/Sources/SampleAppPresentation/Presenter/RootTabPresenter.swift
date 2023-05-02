//
//  RootTabPresenter.swift
//
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import Foundation
import SampleAppCoreUI
import SwiftUI

class RootTabPresenter: ObservableObject {
    @Published var selectedTabType: RootTabType

    // RootTabView の方にも記述したが、init で RootTabType を渡す必要はないかもしれない。
    init(selectedTabType: RootTabType) {
        self.selectedTabType = selectedTabType
    }
}
