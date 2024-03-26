//
//  Post.swift
//  Socialcademy
//
//  Created by Andrew Hoang on 3/25/24.
//

import Foundation

struct Post: Identifiable {
    var title: String
    var content: String
    var authorName: String
    var timestamp = Date()
    var id = UUID()
}
