//
//  PostDTO.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

struct PostDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let createdAt: String
    let updatedAt: String
}
