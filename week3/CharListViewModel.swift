//
//  ChatListViewModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/17/26.
//

import Foundation
import Observation

@Observable
final class ChatListViewModel {
    private(set) var exampleChat: [ChatModel] = [
        ChatModel(
            profileImageName: "kk",
            username: "juju",
            chatcaption: "안녕하세요 주주예용",
            time: "지금"
        ),
        ChatModel(
            profileImageName: "kk",
            username: "huihui",
            chatcaption: "반가워요 희희예용",
            time: "지금"
        ),
        ChatModel(
            profileImageName: "profile",
            username: "tacos",
            chatcaption: "아~ 재밌다 😂😂😂",
            time: "20m"
        ),
        ChatModel(
            profileImageName: "kk",
            username: "kk_kk",
            chatcaption: "나의 노래를 들어보실 분 나는 케케",
            time: "1m"
        ),
        ChatModel(
            profileImageName: "kk",
            username: "hello_moa",
            chatcaption: "모아요에 오신 걸 환영",
            time: "2h"
        ),
        ChatModel(
            profileImageName: "kk",
            username: "goTosleep",
            chatcaption: "쿨쿨...",
            time: "4h"
        ),
        ChatModel(
            profileImageName: "kk",
            username: "hungryMan",
            chatcaption: "저랑 떵개하실래요?",
            time: "5h"
        ),
        ChatModel(
            profileImageName: "kk",
            username: "moamoayo",
            chatcaption: "모아요에서 사과 한 입! 앙",
            time: "10h"
        )
    ]
}
