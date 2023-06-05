//
//  AuthManagerProtocol.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import Foundation

/// @mockable
public protocol AuthManagerProtocol {
    func signUp(username: String, password: String, email: String) async throws
    func confirmSignUp(for username: String, with confirmationCode: String) async throws
    func signIn(username: String, password: String, email: String) async throws
    func signOut() async throws
}
