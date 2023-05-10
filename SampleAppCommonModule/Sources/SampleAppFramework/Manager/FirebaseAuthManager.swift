//
//  FirebaseAuthManager.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import FirebaseAuth
import Foundation
import SampleAppDomain

public enum FirebaseAuthManagerError: Error, LocalizedError {
    case noCurrentUser
}

public class FirebaseAuthManager: AuthManagerProtocol {
    public init() {}

    public func signUp(username _: String, password: String, email: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    public func confirmSignUp(for username: String, with confirmationCode: String) async throws {
        print("confirmSignUp: \(username), \(confirmationCode)")
    }

    public func signIn(username _: String, password: String, email: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    public func signOut() async throws {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try Auth.auth().signOut()
                continuation.resume(returning: ())
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}

private extension FirebaseAuthManager {
    func getUserIdToken() async throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw FirebaseAuthManagerError.noCurrentUser
        }
        return try await user.getIDToken()
    }
}
