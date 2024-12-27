//
//  PostViewModel.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import Foundation

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private let apiService: PostAPIService = PostAPIService()
    
    func fetchPosts() async {
        do {
            posts = try await apiService.fetchPosts()
            print(posts)
        } catch {
            print("Failed to fetch posts: \(error)")
        }
    }
    
    func addPost(title: String, body: String) async {
        let newPost = Post(id: nil, title: title, body: body)
        do {
            let createdPost = try await apiService.createPost(post: newPost)
            posts.insert(createdPost, at: 0)
        } catch {
            print("Failed to add post: \(error)")
        }
    }
    
    func updatePost(post: Post) async {
        do {
            let updatedPost = try await apiService.updatePost(post: post)
            if let index = posts.firstIndex(where: { $0.id == updatedPost.id }) {
                posts[index] = updatedPost
            }
        } catch {
            print("Failed to update post: \(error)")
        }
    }
    
    func deletePost(id: Int) async {
        do {
            try await apiService.deletePost(id: id)
            posts.removeAll { $0.id == id }
        } catch {
            print("Failed to delete post: \(error)")
        }
    }
}
