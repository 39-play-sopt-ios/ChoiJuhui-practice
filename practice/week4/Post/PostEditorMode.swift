//
//  PostEditorMode.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

enum PostEditorMode: Identifiable {
    case create
    case edit(Post)

    var id: String {
        switch self {
        case .create: "create"
        case let .edit(post): "edit-\(post.id)"
        }
    }
}

enum PostEditorResult {
    case created
    case updated(Post)
}
