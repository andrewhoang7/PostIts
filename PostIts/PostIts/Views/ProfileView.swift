//
//  ProfileView.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/30/24.
//

import Foundation
import FirebaseAuth
import SwiftUI

struct ProfileView: View {
    var body: some View {
        Button("Sign Out", action: {
            try! Auth.auth().signOut()
        })
    }
}
