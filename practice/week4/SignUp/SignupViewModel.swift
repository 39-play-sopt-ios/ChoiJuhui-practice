//
//  SignupViewModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation
import Observation

@Observable
final class SignupViewModel {
    var part = ""
    var name = ""
    private(set) var authorizationCode: String?
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private let service: any SignupServicing

    init(service: any SignupServicing = SignupService()) {
        self.service = service
    }

    func requestCode() async {
        guard !isLoading else { return }

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (1...20).contains(trimmedName.count) else {
            errorMessage = "이름은 1~20자로 입력해 주세요."
            return
        }

        isLoading = true
        authorizationCode = nil
        errorMessage = nil
        defer { isLoading = false }

        do {
            let response = try await service.postSignup(part: part)
            try Task.checkCancellation()
            authorizationCode = response.authorizationCode
            AuthorizationStore.shared.save(response.authorizationCode)
            AuthorizationStore.shared.saveNickname(trimmedName)
        } catch is CancellationError {
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
