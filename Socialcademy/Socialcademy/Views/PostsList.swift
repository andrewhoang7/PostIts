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
                    VStack(alignment: .center, spacing: 10) {
                        Text("Cannot Load Posts")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Text(error.localizedDescription)
                        Button(action: {
                            viewModel.fetchPosts()
                        }) {
                            Text("Try Again")
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.secondary))
                        }
                        .padding(.top)
                    }
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
                case .empty:
                    VStack(alignment: .center, spacing: 10) {
                        Text("No Posts")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Text("There aren’t any posts yet.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding()
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
