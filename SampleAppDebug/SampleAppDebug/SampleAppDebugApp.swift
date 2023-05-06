//
//  SampleAppDebugApp.swift
//  SampleAppDebug
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import FirebaseAnalytics
import FirebaseCore
import SwiftUI

@main
struct SampleAppDebugApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Analytics.logEvent("sample_event", parameters: nil)
        return true
    }
}
