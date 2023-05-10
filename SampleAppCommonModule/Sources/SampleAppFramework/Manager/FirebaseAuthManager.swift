//
//  FirebaseAuthManager.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import FirebaseAuth
import Foundation
import SampleAppDomain

public enum MockError: Error, LocalizedError {
    case mockError

    public var errorDescription: String? {
        "MockError"
    }
}

public enum FirebaseAuthManagerError: Error, LocalizedError {
    case noCurrentUser
}

public class FirebaseAuthManager: AuthManagerProtocol {
    public init() {}

    public func createUser(email: String, password: String) async throws -> AuthResult {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthResult(from: authDataResult)
    }

    public func signIn(email: String, password: String) async throws -> AuthResult {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthResult(from: authDataResult)
    }

    public func getUserIdToken() async throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw FirebaseAuthManagerError.noCurrentUser
        }
        return try await user.getIDToken()
    }
}

private extension AuthResult {
    init(from authDataResult: AuthDataResult) {
        let user = authDataResult.user
        self.init(uid: user.uid, displayName: user.displayName, email: user.email)
    }
}
