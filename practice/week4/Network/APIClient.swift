//
//  APIClient.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

struct APIClient {
    static let shared = APIClient()

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: some Endpoint) async throws -> T {
        let response: BaseResponse<T> = try await send(endpoint)
        guard let data = response.data else {
            throw NetworkError.responseDecodingError
        }
        return data
    }

    func request(_ endpoint: some Endpoint) async throws {
        let _: BaseResponse<EmptyData> = try await send(endpoint)
    }

    private func send<T: Decodable>(_ endpoint: some Endpoint) async throws -> BaseResponse<T> {
        let request = try makeRequest(endpoint)
        let (data, response) = try await perform(request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            if let failure = try? JSONDecoder().decode(BaseResponse<EmptyData>.self, from: data) {
                throw NetworkError.serverError(message: failure.message)
            }
            throw NetworkError(statusCode: httpResponse.statusCode)
        }

        let decoded: BaseResponse<T>
        do {
            decoded = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }

        guard decoded.isSuccess else {
            throw NetworkError.serverError(message: decoded.message)
        }
        return decoded
    }

    private func makeRequest(_ endpoint: some Endpoint) throws -> URLRequest {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let baseURL = URL(string: baseURLString) else {
            throw NetworkError.urlError
        }

        var url = baseURL.appending(path: endpoint.path)
        
        if !endpoint.queryItems.isEmpty {
            url.append(queryItems: endpoint.queryItems)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if endpoint.requiresAuthorization {
            guard let code = AuthorizationStore.shared.read() else {
                throw NetworkError.unauthorized
            }
            request.setValue(code, forHTTPHeaderField: "Authorization")
        }

        if let body = endpoint.body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw NetworkError.requestEncodingError
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }

    private func perform(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.networkConnectionError
            case .timedOut:
                throw NetworkError.timeoutError
            case .cancelled:
                throw CancellationError()
            default:
                throw NetworkError.unknownError
            }
        }
    }
}
