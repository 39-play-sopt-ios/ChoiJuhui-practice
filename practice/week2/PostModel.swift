//
//  PostModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/10/26.
//

import Foundation

struct PostModel: Identifiable {
    let id = UUID()
    let profileImageName: String
    let username: String
    let location: String
    let postImageName: String
    let likesText: String
    let caption: String
    let timeText: String
    var isLiked = false
}
