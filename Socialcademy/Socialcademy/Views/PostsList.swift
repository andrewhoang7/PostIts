//
//  PostsList.swift
//  Socialcademy
//
//  Created by Andrew Hoang on 3/25/24.
//

import Foundation
import SwiftUI

struct PostsList: View {
    private var posts = [Post.testPost]
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                PostRow(post: post)
            }
            .navigationTitle("Posts")
        }
    }
}
