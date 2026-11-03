//
//  PostListResponseDTO.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

struct PostListResponseDTO: Decodable {
    let posts: [PostDTO]
    let nextCursor: Int?
    let hasNext: Bool
}
