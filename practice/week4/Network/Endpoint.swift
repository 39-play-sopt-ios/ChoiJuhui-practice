//
//  Endpoint.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var body: (any Encodable)? { get }
    var requiresAuthorization: Bool { get }
}

extension Endpoint {
    var queryItems: [URLQueryItem] { [] }
    var body: (any Encodable)? { nil }
    var requiresAuthorization: Bool { false }
}
