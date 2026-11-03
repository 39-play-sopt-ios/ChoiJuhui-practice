//
//  PostListView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/1/26.
//

import SwiftUI

struct PostListView: View {
    @State private var viewModel = PostListViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            searchBar
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.posts) { post in
                        PostCardView(post: post)
                            .onTapGesture {
                                viewModel.requestEdit(post)
                            }
                            .onLongPressGesture {
                                viewModel.requestDelete(post)
                            }
                            .onAppear {
                                Task { await viewModel.loadMoreIfNeeded(current: post) }
                            }
                    }
                    
                    if viewModel.isLoading && !viewModel.posts.isEmpty {
                        ProgressView()
                            .padding(.vertical, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .refreshable { await viewModel.loadFirstPage() }
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingAddButton {
                viewModel.showCreateSheet()
            }
                .padding(.bottom, 31)
        }
        .padding(.horizontal, 16)
        .task { await viewModel.loadFirstPage() }
        .onChange(of: viewModel.keyword) {
            viewModel.keywordDidChange()
        }
        .sheet(item: $viewModel.editorMode) { mode in
            PostEditorSheet(mode: mode) { result in
                Task { await viewModel.didFinishEditor(result) }
            }
        }
        .confirmAlert(
            item: $viewModel.deleteTarget,
            message: "게시글을 삭제할까요?",
            confirmTitle: "삭제"
        ) { post in
            Task { await viewModel.delete(post) }
        }
    }
    
    private var searchBar: some View {
        HStack {
            TextField("", text: $viewModel.keyword, prompt: Text("검색어를 입력하세요").foregroundStyle(.gray2))
                .submitLabel(.search)
                .onSubmit {
                    submitSearch()
                }
                .font(.m18)
                .foregroundStyle(.gray5)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.horizontal, 16)
                .frame(height: 54)
            
            Button {
                submitSearch()
            } label: {
                Image(.search)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 16)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(isFocused ? .gray5 : .gray2, lineWidth: 2)
        }
    }
    
    private func submitSearch() {
        Task { await viewModel.search() }
        isFocused = false
    }
}

#Preview {
    let _ = AuthorizationStore.shared.save("20001208")
    let _ = AuthorizationStore.shared.saveNickname("주희")
    PostListView()
}
