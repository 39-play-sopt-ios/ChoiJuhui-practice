//
//  PostCreateService.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

protocol PostCreateServicing {
    func createPost(title: String, content: String, author: String) async throws
}

struct PostCreateService: PostCreateServicing {
    private let client: APIClient
    
    init(client: APIClient = .shared) {
        self.client = client
    }
    
    func createPost(title: String, content: String, author: String) async throws {
        let body = PostCreateRequestDTO(title: title, content: content, author: author)
        try await client.request(PostEndpoint.create(body))
    }
}
