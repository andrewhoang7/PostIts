//
//  AuthView.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/30/24.
//

import Foundation
import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()

    var body: some View {
        if viewModel.isAuthenticated {
            MainTabView()
        } else {
            Form {
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                Button("Sign In", action: {
                    viewModel.signIn()
                })
            }
        }
    }
}
