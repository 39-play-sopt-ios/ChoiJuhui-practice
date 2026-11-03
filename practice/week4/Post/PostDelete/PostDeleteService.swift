//
//  PostDeleteService.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

protocol PostDeleteServicing {
    func deletePost(id: Int) async throws
}

struct PostDeleteService: PostDeleteServicing {
    private let client: APIClient
    
    init(client: APIClient = .shared) {
        self.client = client
    }
    
    func deletePost(id: Int) async throws {
        try await client.request(PostEndpoint.delete(id: id))
    }
}
