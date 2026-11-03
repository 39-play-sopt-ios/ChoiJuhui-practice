//
//  PostCreateRequestDTO.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

struct PostCreateRequestDTO: Encodable {
    let title: String
    let content: String
    let author: String
}
