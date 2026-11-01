//
//  PostResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/1/26.
//

import Foundation

struct PostResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: PostListDataDTO?
}

struct PostListDataDTO: Decodable {
    let posts: [PostDTO]
    let nextCursor: Int?
    let hasNext: Bool
}

struct PostDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let createdAt: String
    let updatedAt: String
}
