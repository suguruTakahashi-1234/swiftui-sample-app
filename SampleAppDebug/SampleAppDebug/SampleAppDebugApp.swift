//
//  SampleAppDebugApp.swift
//  SampleAppDebug
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import FirebaseCore
import SwiftUI

@main
struct SampleAppDebugApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
