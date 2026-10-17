//
//  PracticeKeyChainView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/10/26.
//

import SwiftUI
import Security

struct PracticeKeychainView: View {
    private var query: [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.sopt.keychain.practice",
            kSecAttrAccount as String: "sampleToken"
        ]
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Button("추가") {
                addToken()
            }

            Button("조회") {
                readToken()
            }

            Button("수정") {
                updateToken()
            }

            Button("삭제") {
                deleteToken()
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }
    
    private func addToken() {
        var addQuery = query
        addQuery[kSecValueData as String] = Data("sample-token-1".utf8)

        let status = SecItemAdd(addQuery as CFDictionary, nil)
        print("추가 상태:", status)
    }
    
    private func readToken() {
        var readQuery = query
        readQuery[kSecReturnData as String] = true
        readQuery[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: CFTypeRef?
        let status = SecItemCopyMatching(readQuery as CFDictionary, &result)
        print("조회 상태:", status)

        if status == errSecSuccess, let data = result as? Data {
            print("조회한 값:", String(decoding: data, as: UTF8.self))
        } else if status == errSecItemNotFound {
            print("저장된 토큰이 없어요.")
        }
    }
    
    private func updateToken() {
        let newValue: [String: Any] = [
            kSecValueData as String: Data("sample-token-2".utf8)
        ]

        let status = SecItemUpdate(
            query as CFDictionary,
            newValue as CFDictionary
        )
        print("수정 상태:", status)
    }
    
    private func deleteToken() {
            let status = SecItemDelete(query as CFDictionary)
            print("삭제 상태:", status)
        }
 }


