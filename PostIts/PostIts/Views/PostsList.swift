//
//  PostsList.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/25/24.
//

import Foundation
import SwiftUI

struct PostsList: View {
    @StateObject var viewModel: PostsViewModel
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
            Group {
                switch viewModel.posts {
                case .loading:
                    ProgressView()
                case let .error(error):
                    EmptyListView(title: "Cannot Load Posts", 
                                  message: error.localizedDescription) {
                        viewModel.fetchAllPosts()
                    }
                case .empty:
                    EmptyListView(title: "No Posts", 
                                  message: "There aren't any posts yet")
                case let .loaded(posts):
                    ScrollView {
                        ForEach(posts) { post in
                            if searchText.isEmpty || post.contains(searchText) {
                                PostRow(viewModel: viewModel.makePostRowViewModel(for: post))
                            }
                        }
                        .searchable(text: $searchText)
                        .animation(.default, value: posts)
                    }
                }
            }

            .navigationTitle(viewModel.title)
            .toolbar {
                Button(action: {
                    showNewPostForm = true
                }, label: {
                    Label("New Post", systemImage: "square.and.pencil")
                })
            }
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm(viewModel: viewModel.makeNewPostViewModel())
            }
            .onAppear() {
                viewModel.fetchAllPosts()
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
            NavigationView {
                PostsList(viewModel: viewModel)
            }
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
