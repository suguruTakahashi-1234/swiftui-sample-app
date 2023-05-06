//
//  SettingView.swift
//
//
//  Created by Suguru Takahashi on 2023/04/26.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Button("Crash") {
                fatalError("Crash was triggered")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
