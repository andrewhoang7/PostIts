//
//  Post.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/25/24.
//

import Foundation

struct Post: Identifiable, Codable, Equatable {
    var title: String
    var content: String
    var author: User
    var isFavorite = false
    var timestamp = Date()
    var id = UUID()
    
    func contains(_ string: String) -> Bool {
        let properties = [title, content, author.name].map {$0.lowercased()}
        let query = string.lowercased()
        let matches = properties.filter { $0.contains(query) }
        return !matches.isEmpty
    }
}



extension Post {
    static let testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        author: User.testUser
    )
}
