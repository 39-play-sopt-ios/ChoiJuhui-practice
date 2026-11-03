//
//  SignupEndpoint.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

enum SignupEndpoint: Endpoint {
    case authorizationCode(SignupRequestDTO)
    
    var path: String { "/api/v1/members/authorization-code" }
    var method: HTTPMethod { .post }
    
    var body: (any Encodable)? {
        switch self {
        case let .authorizationCode(dto): dto
        }
    }
}
