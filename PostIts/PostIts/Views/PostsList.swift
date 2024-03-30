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
                            PostRow(
                                post: post,
                                deleteAction: viewModel.makeDeleteAction(for: post)
                            )
                        }
                    }
                }
            }

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

#if DEBUG
struct PostList_Previews: PreviewProvider {
    
    @MainActor
    private struct ListPreview: View {
        let state: Loadable<[Post]>
        var body: some View {
            let postsRepository = PostsRepositoryStub(state: state)
            let viewModel = PostsViewModel(postsRepository: postsRepository)
            PostsList(viewModel: viewModel)
        }
    }
    
    static var previews: some View {
        ListPreview(state: .loaded([Post.testPost]))
        ListPreview(state: .empty)
        ListPreview(state: .error)
        ListPreview(state: .loading)
    }
}
#endif