//
//  AuthorizationStore.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation
import Security

struct AuthorizationStore {
    static let shared = AuthorizationStore()

    private let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: "com.sopt.seminar",
        kSecAttrAccount as String: "authorizationCode"
    ]
    private let nicknameKey = "nickname"

    func save(_ code: String) {
        SecItemDelete(query as CFDictionary)

        var addQuery = query
        addQuery[kSecValueData as String] = Data(code.utf8)
        SecItemAdd(addQuery as CFDictionary, nil)
    }

    func read() -> String? {
        var readQuery = query
        readQuery[kSecReturnData as String] = true
        readQuery[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: CFTypeRef?
        guard SecItemCopyMatching(readQuery as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }
        return String(decoding: data, as: UTF8.self)
    }
    
    func saveNickname(_ nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    func readNickname() -> String? {
        UserDefaults.standard.string(forKey: nicknameKey)
    }
}
