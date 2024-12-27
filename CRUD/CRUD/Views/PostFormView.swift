//
//  PostFormView.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import SwiftUI

struct PostFormView: View {
    @ObservedObject var viewModel: PostViewModel
    @Binding var post: Post?
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var description = ""

    var isEditing: Bool {
        post != nil
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.headline)
                        TextEditor(text: $title)
                            .styledTextEditor(minHeight: 30)
                    }
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                        TextEditor(text: $description)
                            .styledTextEditor(minHeight: 100)
                    }
                }
                .padding()
            }
            .navigationTitle(isEditing ? "Edit Post" : "Add Post")
            .toolbar {
                Button("Save") {
                    Task {
                        if isEditing, let post = post {
                            var updatedPost = post
                            updatedPost.title = title
                            updatedPost.body = description
                            await viewModel.updatePost(post: updatedPost)
                        } else {
                            await viewModel.addPost(title: title, body: description)
                        }
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let post = post {
                    title = post.title
                    description = post.body
                }
            }
        }
    }
}
