//
//  PostListService.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/1/26.
//

import Foundation


final class PostListService {
    static let shared = PostListService()
    
    private init() {}
    
    private func makeRequest(keyword: String?, cursor: Int?, size: Int?) throws -> URLRequest {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: baseURL) else {
            throw NetworkError.urlError
        }
        
        let queryItems = [
            keyword.map { URLQueryItem(name: "keyword", value: $0) },
            cursor.map { URLQueryItem(name: "cursor", value: String($0)) },
            size.map { URLQueryItem(name: "size", value: String($0)) }
        ].compactMap { $0 }
        
        var requestURL = url.appending(path: "/api/v1/posts")
        
        if !queryItems.isEmpty {
            requestURL.append(queryItems: queryItems)
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        return request
    }
    
    func fetchPosts(keyword: String? = nil, cursor: Int? = nil, size: Int? = nil) async throws -> PostResponseDTO {
        let request = try makeRequest(keyword: keyword, cursor: cursor, size: size)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(PostResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
