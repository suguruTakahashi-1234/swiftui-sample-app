//
//  ContentView.swift
//  SampleAppSandbox
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import SampleAppPresentation
import SwiftUI

struct ContentView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ScrollView(.vertical) {
                    LoginView()
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
