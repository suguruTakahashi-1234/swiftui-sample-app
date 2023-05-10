//
//  File.swift
//
//
//  Created by Suguru Takahashi on 2023/05/10.
//

import Foundation
import SwiftUI

public struct LoginView: View {
    @StateObject private var loginPresenter = LoginPresenter()

    public init() {}

    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ScrollView(.vertical) {
                    VStack {
                        TextField("Email", text: $loginPresenter.email)
                            .padding()
                            .autocapitalization(.none)
                            .disableAutocorrection(true)

                        SecureField("Password", text: $loginPresenter.password)
                            .padding()
                            .autocapitalization(.none)
                            .disableAutocorrection(true)

                        Text("Welcome, \(loginPresenter.idToken)")
                            .padding()

                        Button {
                            Task { await loginPresenter.createUser() }
                        } label: {
                            Text("Register")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }

                        Button {
                            Task { await loginPresenter.signIn() }
                        } label: {
                            Text("Login")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }

                        Button {
                            Task { await loginPresenter.signOut() }
                        } label: {
                            Text("Log out")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .alert(isPresented: $loginPresenter.showAlert) {
                        Alert(title: Text("Error"), message: Text(loginPresenter.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
