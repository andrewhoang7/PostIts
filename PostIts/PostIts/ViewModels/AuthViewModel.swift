//
//  AuthViewModel.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/30/24.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isAuthenticated = false
    
    private let authService = AuthService()
    
    init() {
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            } catch {
                print("[AuthViewModel] Cannot sign in: \(error)")
            }
        }
    }
}
