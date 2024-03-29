//
//  PostsList.swift
//  Socialcademy
//
//  Created by Andrew Hoang on 3/25/24.
//

import Foundation
import SwiftUI

struct PostsList: View {
    @StateObject var viewModel = PostsViewModel()
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                if searchText.isEmpty || post.contains(searchText) {
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
            .toolbar {
                Button(action: {
                    showNewPostForm = true
                }, label: {
                    Label("New Post", systemImage: "square.and.pencil")
                })
            }
        }
        .onAppear() {
            viewModel.fetchPosts()
        }
        .sheet(isPresented: $showNewPostForm) {
            NewPostForm(createAction: viewModel.makeCreateAction())
        }
    }
}
