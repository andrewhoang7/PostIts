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
        VStack(alignment: .leading, spacing: 10){
            HStack {
                Text(post.authorName)
                    .font(.subheadline)
                .fontWeight(.medium)
                Spacer()
                Text(post.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundStyle(.gray)
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(post.content)
        }
        .padding(.vertical)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PostRow(post: Post.testPost)
        }
    }
}

