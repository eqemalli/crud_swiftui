//
//  ContentView.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var showingForm = false
    @State private var selectedPost: Post?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        selectedPost = post
                        showingForm = true
                    }
                }
                .onDelete(perform: deletePost)
            }
            .navigationTitle("Posts")
            .toolbar {
                Button("Add Post") {
                    selectedPost = nil
                    showingForm = true
                }
            }
            .task {
                await viewModel.fetchPosts()
            }
            .sheet(isPresented: $showingForm) {
                PostFormView(viewModel: viewModel, post: $selectedPost)
            }
        }
    }
    
    private func deletePost(at offsets: IndexSet) {
        for index in offsets {
            let post = viewModel.posts[index]
            Task {
                await viewModel.deletePost(id: post.id ?? 0)
            }
        }
    }
}

#Preview {
    PostListView()
}
