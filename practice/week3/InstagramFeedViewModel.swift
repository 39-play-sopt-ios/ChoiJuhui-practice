//
//  InstagramFeedViewModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/17/26.
//

import Foundation
import Observation

@Observable
final class InstagramFeedViewModel {
    private(set) var examplePosts: [PostModel] = [
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
    
    var likedCount: Int {
        examplePosts.filter { $0.isLiked }.count
    }
    
    func toggleLike(id: PostModel.ID) {
        guard let index = examplePosts.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        examplePosts[index].isLiked.toggle()
    }
    
    func delete(ids: [PostModel.ID]) {
        examplePosts.removeAll { ids.contains($0.id)}
    }
}
