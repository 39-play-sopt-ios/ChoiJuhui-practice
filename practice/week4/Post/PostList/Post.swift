//
//  Post.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

struct Post: Identifiable, Hashable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let createdDate: String
}

extension Post {
    init(dto: PostDTO) {
        self.id = dto.id
        self.title = dto.title
        self.content = dto.content
        self.author = dto.author
        self.createdDate = String(dto.createdAt.prefix(10))
            .replacingOccurrences(of: "-", with: ".")
    }
}
