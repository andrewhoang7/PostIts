//
//  PostsList.swift
//  Socialcademy
//
//  Created by Andrew Hoang on 3/25/24.
//

import Foundation
import SwiftUI

struct PostList: View {
    private var posts = [Post.testPost]
    
    var body: some View {
        List(posts) { post in
            Text(post.content)
        }
    }
}
