//
//  PostEditorViewModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation
import Observation

@Observable
final class PostEditorViewModel {
    static let titleLimit = 20
    static let contentLimit = 1000

    var title = "" {
        didSet {
            if title.count > Self.titleLimit {
                title = String(title.prefix(Self.titleLimit))
            }
        }
    }

    var content = "" {
        didSet {
            if content.count > Self.contentLimit {
                content = String(content.prefix(Self.contentLimit))
            }
        }
    }

    private(set) var isSubmitting = false
    private(set) var errorMessage: String?

    private let mode: PostEditorMode
    private let createService: any PostCreateServicing
    private let updateService: any PostUpdateServicing

    init(
        mode: PostEditorMode,
        createService: any PostCreateServicing = PostCreateService(),
        updateService: any PostUpdateServicing = PostUpdateService()
    ) {
        self.mode = mode
        self.createService = createService
        self.updateService = updateService

        if case let .edit(post) = mode {
            title = post.title
            content = post.content
        }
    }

    var isSubmitEnabled: Bool {
        guard !trimmedTitle.isEmpty, !trimmedContent.isEmpty, !isSubmitting else {
            return false
        }

        if case let .edit(post) = mode {
            return trimmedTitle != post.title || trimmedContent != post.content
        }
        return true
    }

    func submit() async -> PostEditorResult? {
        guard isSubmitEnabled else { return nil }

        isSubmitting = true
        errorMessage = nil
        defer { isSubmitting = false }

        do {
            switch mode {
            case .create:
                guard let nickname = AuthorizationStore.shared.readNickname() else {
                    errorMessage = "먼저 인증 코드를 발급받아 주세요."
                    return nil
                }
                try await createService.createPost(
                    title: trimmedTitle,
                    content: trimmedContent,
                    author: nickname
                )
                return .created
                
            case let .edit(post):
                let updated = try await updateService.updatePost(
                    id: post.id,
                    title: trimmedTitle,
                    content: trimmedContent
                )
                return .updated(Post(dto: updated))
            }
        } catch is CancellationError {
            return nil
        } catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedContent: String {
        content.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
