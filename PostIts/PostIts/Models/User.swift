//
//  User.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/30/24.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
}

extension User {
    static let testUser = User(id: "", name: "Jamie Harris")
}
