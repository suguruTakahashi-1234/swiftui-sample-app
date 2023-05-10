//
//  AmplifyAuthManager.swift
//
//
//  Created by Suguru Takahashi on 2023/05/11.
//

import Amplify
import AWSCognitoAuthPlugin
import Foundation
import SampleAppDomain

public enum AmplifyAuthManagerError {}

public class AmplifyAuthManager: AuthManagerProtocol {
    public init() {}

    public func signUp(username: String, password: String, email: String) async throws {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)

        let signUpResult: AuthSignUpResult = try await Amplify.Auth.signUp(username: username, password: password, options: options)
        if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
            print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
        } else {
            print("SignUp Complete")
        }
        await fetchCurrentAuthSession()
    }

    public func confirmSignUp(for username: String, with confirmationCode: String) async throws {
        let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode)
        print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
        await fetchCurrentAuthSession()
    }

    public func signIn(username: String, password: String, email _: String) async throws {
        let signInResult = try await Amplify.Auth.signIn(username: username, password: password)
        if signInResult.isSignedIn {
            print("Sign in succeeded")
        }
        await fetchCurrentAuthSession()
    }

    public func signOut() async throws {
        let _ = await Amplify.Auth.signOut()
        await fetchCurrentAuthSession()
    }
}

private extension AmplifyAuthManager {
    func fetchCurrentAuthSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            print("Is user signed in - \(session.isSignedIn)")
        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
