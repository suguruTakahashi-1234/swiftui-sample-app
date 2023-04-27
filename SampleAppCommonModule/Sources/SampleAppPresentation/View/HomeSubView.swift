//
//  HomeSubView.swift
//  
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import SwiftUI

struct HomeSubView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button("モーダルを閉じる") {
            dismiss()
        }
    }
}

struct HomeSubView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSubView()
    }
}
