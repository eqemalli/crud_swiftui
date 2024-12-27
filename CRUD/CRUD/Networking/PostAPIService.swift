//
//  PostAPIService.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import Foundation

class PostAPIService: PostAPIServiceProtocol {
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: baseURL) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    func createPost(post: Post) async throws -> Post {
        guard let url = URL(string: baseURL) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(post)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
    
    func updatePost(post: Post) async throws -> Post {
        guard let id = post.id, let url = URL(string: "\(baseURL)/\(id)") else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(post)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
    
    func deletePost(id: Int) async throws {
        guard let url = URL(string: "\(baseURL)/\(id)") else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        _ = try await URLSession.shared.data(for: request)
    }
}
