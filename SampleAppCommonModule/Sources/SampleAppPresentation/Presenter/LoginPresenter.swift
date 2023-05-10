//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import Foundation
import SampleAppDomain
import SampleAppFramework

class LoginPresenter: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var idToken: String = ""

    private let authManager: AuthManagerProtocol

    init(authManager: AuthManagerProtocol = FirebaseAuthManager()) {
        self.authManager = authManager
    }

    @MainActor
    func createUser() async {
        do {
            let _ = try await authManager.createUser(email: email, password: password)
            print("User created successfully")
        } catch {
            alertMessage = "Error creating user: \(error.localizedDescription)"
            showAlert = true
        }
    }

    @MainActor
    func signIn() async {
        do {
            let _ = try await authManager.signIn(email: email, password: password)
            let idToken = try await authManager.getUserIdToken()
            self.idToken = idToken
            print("User signed in successfully")
        } catch {
            alertMessage = "Error signing in: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
