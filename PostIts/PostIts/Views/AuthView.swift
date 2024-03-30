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
            NavigationView {
                NavigationView {
                    SignInForm(viewModel: viewModel.makeSignInViewModel()) {
                        NavigationLink("Create Account", destination: CreateAccountForm(viewModel: viewModel.makeCreateAccountViewModel()))
                    }
                }
            }
        }
    }
}

private extension AuthView {
    struct CreateAccountForm: View {
        @StateObject var viewModel: AuthViewModel.CreateAccountViewModel
        
        var body: some View {
            Form {
                TextField("Name", text: $viewModel.name)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
                Button("Create Account", action: viewModel.submit)
            }
            .navigationTitle("Create Account")
            .onSubmit(viewModel.submit)
        }
    }
    
    struct SignInForm<Footer: View>: View {
        @StateObject var viewModel: AuthViewModel.SignInViewModel
        @ViewBuilder let footer: () -> Footer
        
        var body: some View {
            Form {
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                Button("Sign In", action: viewModel.submit)
                footer()
            }
            .navigationTitle("Sign In")
            .onSubmit(viewModel.submit)
        }
    }
}
