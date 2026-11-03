//
//  BaseResponse.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: T?
}

struct EmptyData: Decodable {}
