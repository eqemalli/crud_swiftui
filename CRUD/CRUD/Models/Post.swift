//
//  Post.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int?
    var title: String
    var body: String
}
