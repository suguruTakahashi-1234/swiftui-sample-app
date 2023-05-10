//
//  AuthManagerProtocol.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import Foundation

/// @mockable
public protocol AuthManagerProtocol {
    func createUser(email: String, password: String) async throws -> AuthResult
    func signIn(email: String, password: String) async throws -> AuthResult
    func getUserIdToken() async throws -> String
}
