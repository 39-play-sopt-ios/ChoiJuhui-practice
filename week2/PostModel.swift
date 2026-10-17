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

let examplePosts: [PostModel] = [
    PostModel(
        profileImageName: "profile",
        username: "최주희",
        location: "서울, 대한민국",
        postImageName: "feed3",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "벌써 2차 세미나라니 정말 즐거워요!",
        timeText: "1시간 전"
    ),
    PostModel(
        profileImageName: "profile",
        username: "모아요",
        location: "아요의 숲",
        postImageName: "feed2",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "2차 세미나 끝냅시다",
        timeText: "2시간 전"
    ),
    PostModel(
        profileImageName: "profile",
        username: "모아요",
        location: "서울, 대한민국",
        postImageName: "feed",
        likesText: "모아요님 외 7,777명이 좋아합니다",
        caption: "나나나",
        timeText: "3시간 전"
    )
]
