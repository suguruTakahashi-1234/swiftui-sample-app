//
//  SampleAppDebugApp.swift
//  SampleAppDebug
//
//  Created by Suguru Takahashi on 2023/04/27.
//

import FirebaseAnalytics
import FirebaseCore
import FirebaseCrashlytics
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

        // Firebase Crashlytics サンプルカスタムvalue設定
        Crashlytics.crashlytics().setCustomValue("sample_str_key", forKey: "str_key")

        // Firebase Analytics サンプルイベント送信
        Analytics.logEvent("sample_event", parameters: nil)

        return true
    }
}
