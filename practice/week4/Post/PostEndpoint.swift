//
//  PostEndpoint.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

enum PostEndpoint: Endpoint {
    case list(keyword: String?, cursor: Int?, size: Int?)
    case create(PostCreateRequestDTO)
    case delete(id: Int)
    case update(id: Int, PostUpdateRequestDTO)
    
    private static let base = "/api/v1/posts"
    
    var path: String {
        switch self {
        case .list, .create: Self.base
        case let .delete(id), let .update(id, _): "\(Self.base)/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list: .get
        case .create: .post
        case .delete: .delete
        case .update: .put
        }
    }
    
    var queryItems: [URLQueryItem] {
        guard case let .list(keyword, cursor, size) = self else {
            return []
        }
        return [
                    keyword.map { URLQueryItem(name: "keyword", value: $0) },
                    cursor.map { URLQueryItem(name: "cursor", value: String($0)) },
                    size.map { URLQueryItem(name: "size", value: String($0)) }
                ].compactMap { $0 }
    }
    
    var body: (any Encodable)? {
        switch self {
        case .list, .delete: nil
        case let .create(dto): dto
        case let .update(_, dto): dto
        }
    }
    
    var requiresAuthorization: Bool {
        switch self {
        case .list: false
        case .create, .delete, .update: true
        }
    }
}


