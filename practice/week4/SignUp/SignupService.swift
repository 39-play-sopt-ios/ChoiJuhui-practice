//
//  SignupService.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/31/26.
//

import Foundation

protocol SignupServicing {
    func postSignup(part: String) async throws -> AuthorizationCodeResponseDTO
}

struct SignupService: SignupServicing {
    private let client: APIClient
    
    init(client: APIClient = .shared) {
        self.client = client
    }
    
    func postSignup(part: String) async throws -> AuthorizationCodeResponseDTO {
        try await client.request(SignupEndpoint.authorizationCode(.init(part: part)))
    }
}
