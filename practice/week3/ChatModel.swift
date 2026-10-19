//
//  ChatModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/17/26.
//

import Foundation

struct ChatModel: Identifiable {
    let id = UUID()
    let profileImageName: String
    let username: String
    let chatcaption: String
    let time: String
}
