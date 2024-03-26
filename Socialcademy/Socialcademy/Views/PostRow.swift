//
//  PostRow.swift
//  Socialcademy
//
//  Created by Andrew Hoang on 3/26/24.
//

import Foundation
import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack {
            Text(post.authorName)
            Text(post.timestamp.formatted())
            Text(post.title)
            Text(post.content)
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PostRow(post: Post.testPost)
        }
    }
}

