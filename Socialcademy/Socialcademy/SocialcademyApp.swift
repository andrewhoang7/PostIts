//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Andrew Hoang on 3/25/24.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            PostsList()
        }
    }
}
