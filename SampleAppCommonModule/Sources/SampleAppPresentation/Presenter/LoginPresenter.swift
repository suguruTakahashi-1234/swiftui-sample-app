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
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationCode: String = ""
    @Published var showAlert: Bool = false
    @Published private(set) var alertMessage: String = ""

    private let authManager: AuthManagerProtocol

    init(authManager: AuthManagerProtocol = AmplifyAuthManager()) {
        self.authManager = authManager
    }

    @MainActor
    func signUp() async {
        do {
            try await authManager.signUp(username: username, password: password, email: email)
            print("User created successfully")
        } catch {
            alertMessage = "Error creating user: \(error.localizedDescription)"
            showAlert = true
        }
    }

    @MainActor
    func confirmSignUp() async {
        do {
            try await authManager.confirmSignUp(for: username, with: confirmationCode)
            print("User confirmed successfully")
        } catch {
            alertMessage = "Error confirming user: \(error.localizedDescription)"
            showAlert = true
        }
    }

    @MainActor
    func signIn() async {
        do {
            try await authManager.signIn(username: username, password: password, email: email)
            print("User signed in successfully")
        } catch {
            alertMessage = "Error signing in: \(error.localizedDescription)"
            showAlert = true
        }
    }

    @MainActor
    func signOut() async {
        do {
            try await authManager.signOut()
        } catch {
            alertMessage = "Error signing in: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
