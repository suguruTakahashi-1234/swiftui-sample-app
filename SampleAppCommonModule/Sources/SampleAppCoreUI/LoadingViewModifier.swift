//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/06/04.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var allowsGesture: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .allowsHitTesting(!allowsGesture)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                    .allowsHitTesting(!allowsGesture)
            }
        }
    }
}

public extension View {
    func overlayLoading(isPresented: Binding<Bool>, allowsGesture: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isPresented: isPresented, allowsGesture: allowsGesture))
    }
}
