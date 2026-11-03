//
//  PostListViewModel.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import Foundation
import Observation

@Observable
final class PostListViewModel {
    var keyword = ""
    var errorMessage: String?
    var editorMode: PostEditorMode?
    var deleteTarget: Post?
    private(set) var posts: [Post] = []
    private(set) var isLoading = false

    private var appliedKeyword: String?
    private var nextCursor: Int?
    private var hasNext = true

    private var fetchTask: Task<Void, Never>?
    private var searchTask: Task<Void, Never>?
    private var deletingIDs: Set<Int> = []

    private let listService: any PostListServicing
    private let deleteService: any PostDeleteServicing
    private let pageSize = 10
    private let prefetchThreshold = 3
    private let debounceDuration: Duration = .milliseconds(400)

    init(
        listService: any PostListServicing = PostListService(),
        deleteService: any PostDeleteServicing = PostDeleteService()
    ) {
        self.listService = listService
        self.deleteService = deleteService
    }

    func loadFirstPage() async {
        await startFetch(reset: true)
    }

    func loadMoreIfNeeded(current post: Post) async {
        guard posts.suffix(prefetchThreshold).contains(where: { $0.id == post.id }) else { return }
        guard hasNext, !isLoading else { return }
        await startFetch(reset: false)
    }

    func search() async {
        searchTask?.cancel()
        await performSearch(isManual: true)
    }

    func keywordDidChange() {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(for: debounceDuration)
            guard !Task.isCancelled else { return }
            await performSearch(isManual: false)
        }
    }

    private func performSearch(isManual: Bool) async {
        let trimmed = keyword.trimmingCharacters(in: .whitespacesAndNewlines)

        if !trimmed.isEmpty, !(2...50).contains(trimmed.count) {
            if isManual {
                errorMessage = "검색어는 2~50자로 입력해 주세요."
            }
            return
        }

        let newKeyword = trimmed.isEmpty ? nil : trimmed
        guard isManual || newKeyword != appliedKeyword else { return }

        appliedKeyword = newKeyword
        await startFetch(reset: true)
    }

    func requestDelete(_ post: Post) {
        deleteTarget = post
    }

    func delete(_ post: Post) async {
        deleteTarget = nil

        guard deletingIDs.insert(post.id).inserted else { return }
        defer { deletingIDs.remove(post.id) }

        do {
            try await deleteService.deletePost(id: post.id)
            posts.removeAll { $0.id == post.id }
        } catch is CancellationError {
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func showCreateSheet() {
        editorMode = .create
    }

    func requestEdit(_ post: Post) {
        editorMode = .edit(post)
    }

    func didFinishEditor(_ result: PostEditorResult) async {
        switch result {
        case .created:
            await loadFirstPage()
        case let .updated(post):
            guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
            posts[index] = post
        }
    }

    private func startFetch(reset: Bool) async {
        if reset {
            fetchTask?.cancel()
        } else if isLoading {
            return
        }

        let task = Task { await fetch(reset: reset) }
        fetchTask = task
        await task.value
    }

    private func fetch(reset: Bool) async {
        isLoading = true
        defer { if !Task.isCancelled { isLoading = false } }

        do {
            let page = try await listService.fetchPosts(
                keyword: appliedKeyword,
                cursor: reset ? nil : nextCursor,
                size: pageSize
            )

            guard !Task.isCancelled else { return }

            let newPosts = page.posts.map(Post.init(dto:))
            posts = reset ? newPosts : posts + newPosts
            nextCursor = page.nextCursor
            hasNext = page.hasNext
        } catch is CancellationError {
        } catch {
            errorMessage = (error as? NetworkError)?.errorDescription
                ?? "게시글을 불러오지 못했어요."
        }
    }
}
