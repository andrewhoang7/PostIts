//
//  PostsViewModel.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/27/24.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: Loadable<[Post]> = .loading
    
    enum Filter {
        case all, author(User), favorites
    }
    
    private let postsRepository: PostsRepositoryProtocol
    private let filter: Filter
    
    var title: String {
        switch filter {
        case .all:
            return "Posts"
        case let .author(author):
            return "\(author.name)’s Posts"
        case .favorites:
            return "Favorites"
        }
    }
    
    init(filter: Filter = .all, postsRepository: PostsRepositoryProtocol) {
        self.filter = filter
        self.postsRepository = postsRepository
    }
    
    func makePostRowViewModel(for post: Post) -> PostRowViewModel {
        let deleteAction = { [weak self] in
            try await self?.postsRepository.delete(post)
            self?.posts.value?.removeAll { $0 == post }
        }
        let favoriteAction = { [weak self] in
            let newValue = !post.isFavorite
            try await newValue ? self?.postsRepository.favorite(post) : self?.postsRepository.unfavorite(post)
            guard let i = self?.posts.value?.firstIndex(of: post) else { return }
            self?.posts.value?[i].isFavorite = newValue
        }
        return PostRowViewModel(
            post: post,
            deleteAction: postsRepository.canDelete(post) ? deleteAction : nil,
            favoriteAction: favoriteAction
        )
    }
    
    func fetchAllPosts() {
        Task {
            do {
                posts = .loaded(try await postsRepository.fetchPosts(matching: filter))
            } catch {
                print("[PostsViewModel] Cannot fetch posts: \(error)")
                posts = .error(error)
            }
        }
    }
    
    func makeDeleteAction(for post: Post) -> PostRow.Action {
        return { [weak self] in
            try await self?.postsRepository.delete(post)
            self?.posts.value?.removeAll { $0.id == post.id }
        }
    }
    
    func makeFavoriteAction(for post: Post) -> () async throws -> Void {
        return { [weak self] in
            let newValue = !post.isFavorite
            try await newValue ? self?.postsRepository.favorite(post) : self?.postsRepository.unfavorite(post)
            guard let i = self?.posts.value?.firstIndex(of: post) else { return }
            self?.posts.value?[i].isFavorite = newValue
        }
    }
    
    func makeNewPostViewModel() -> FormViewModel<Post> {
        return FormViewModel(
            initialValue: Post(title: "", content: "", author: postsRepository.user),
            action: { [weak self] post in
                try await self?.postsRepository.create(post)
                self?.posts.value?.insert(post, at: 0)
            }
        )
    }

}

private extension PostsRepositoryProtocol {
    func fetchPosts(matching filter: PostsViewModel.Filter) async throws -> [Post] {
        switch filter {
        case .all:
            return try await fetchAllPosts()
        case let .author(author):
            return try await fetchPosts(by: author)
        case .favorites:
            return try await fetchFavoritePosts()
        }
    }
}
