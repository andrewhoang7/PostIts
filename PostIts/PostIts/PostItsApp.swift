//
//  PostItsApp.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/25/24.
//

import SwiftUI
import Firebase

@main
struct PostItsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
