//
//  PostListViewModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class PostListViewModel {
    var keyword = ""
    var errorMessage: String?
    private(set) var posts: [Post] = []
    private(set) var isLoading = false

    @ObservationIgnored private var appliedKeyword: String?
    @ObservationIgnored private var nextCursor: Int?
    @ObservationIgnored private var hasNext = true
    @ObservationIgnored private let service = PostListService.shared
    private let pageSize = 10

    func loadFirstPage() async {
        await fetch(reset: true)
    }

    func loadMoreIfNeeded(current post: Post) async {
        guard post.id == posts.last?.id else { return }
        await fetch(reset: false)
    }

    func search() async {
        let trimmed = keyword.trimmingCharacters(in: .whitespacesAndNewlines)

        if !trimmed.isEmpty, !(2...50).contains(trimmed.count) {
            errorMessage = "검색어는 2~50자로 입력해 주세요."
            return
        }

        appliedKeyword = trimmed.isEmpty ? nil : trimmed
        await fetch(reset: true)
    }

    private func fetch(reset: Bool) async {
        guard !isLoading else { return }
        guard reset || hasNext else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await service.fetchPosts(
                keyword: appliedKeyword,
                cursor: reset ? nil : nextCursor,
                size: pageSize
            )

            guard response.isSuccess, let data = response.data else {
                errorMessage = response.message
                return
            }

            let newPosts = data.posts.map(Post.init(dto:))
            posts = reset ? newPosts : posts + newPosts
            nextCursor = data.nextCursor
            hasNext = data.hasNext
        } catch {
            errorMessage = "게시글을 불러오지 못했어요."
        }
    }
}
