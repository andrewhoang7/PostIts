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
            Group {
                switch viewModel.posts {
                case .loading:
                    ProgressView()
                case let .error(error):
                    EmptyListView(title: "Cannot Load Posts", message: error.localizedDescription) {
                        viewModel.fetchPosts()
                    }
                case .empty:
                    EmptyListView(title: "No Posts", message: "There aren't any posts yet")
                case let .loaded(posts):
                    List(posts) { post in
                        if searchText.isEmpty || post.contains(searchText) {
                            PostRow(post: post)
                        }
                    }
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
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm(createAction: viewModel.makeCreateAction())
            }
        }
        .onAppear() {
            viewModel.fetchPosts()
        }

    }
}
