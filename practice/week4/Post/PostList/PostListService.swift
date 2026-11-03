//
//  PostListService.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/1/26.
//

import Foundation

protocol PostListServicing {
    func fetchPosts(keyword: String?, cursor: Int?, size: Int?) async throws -> PostListResponseDTO
}

struct PostListService: PostListServicing {
    private let client: APIClient
    
    init(client: APIClient = .shared) {
        self.client = client
    }
    
    func fetchPosts(keyword: String?, cursor: Int?, size: Int?) async throws -> PostListResponseDTO {
        try await client.request(PostEndpoint.list(keyword: keyword, cursor: cursor, size: size))
    }
}
