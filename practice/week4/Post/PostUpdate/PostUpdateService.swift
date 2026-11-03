//
//  PostUpdateService.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

protocol PostUpdateServicing {
    func updatePost(id: Int, title: String, content: String) async throws -> PostDTO
}

struct PostUpdateService: PostUpdateServicing {
    private let client: APIClient

    init(client: APIClient = .shared) {
        self.client = client
    }

    func updatePost(id: Int, title: String, content: String) async throws -> PostDTO {
        let body = PostUpdateRequestDTO(title: title, content: content)
        return try await client.request(PostEndpoint.update(id: id, body))
    }
}
