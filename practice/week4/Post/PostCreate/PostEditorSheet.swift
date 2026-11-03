//
//  PostCreateSheet.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import SwiftUI

struct PostEditorSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: PostEditorViewModel

    let onComplete: (PostEditorResult) -> Void

    init(mode: PostEditorMode, onComplete: @escaping (PostEditorResult) -> Void) {
        _viewModel = State(initialValue: PostEditorViewModel(mode: mode))
        self.onComplete = onComplete
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            fieldLabel("제목")
            inputField(
                prompt: "제목을 입력하세요.",
                text: $viewModel.title
            )

            fieldLabel("본문")
                .padding(.top, 12)
            inputField(
                prompt: "본문을 입력하세요.",
                text: $viewModel.content,
                axis: .vertical
            )

            Button {
                Task {
                    if let result = await viewModel.submit() {
                        onComplete(result)
                        dismiss()
                    }
                }
            } label: {
                Text("완료")
                    .font(.sb14)
                    .foregroundStyle(viewModel.isSubmitEnabled ? .white : .gray3)
                    .frame(maxWidth: .infinity, minHeight: 49)
                    .background(
                        viewModel.isSubmitEnabled ? .black : .gray1,
                        in: .capsule
                    )
            }
            .buttonStyle(.plain)
            .disabled(!viewModel.isSubmitEnabled)
            .padding(.top, 20)
        }
        .padding(.horizontal, 16)
        .presentationBackground(.white)
        .presentationDetents([.height(299)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(24)
    }

    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(.subhead2)
            .foregroundStyle(.gray6)
    }

    private func inputField(
        prompt: String,
        text: Binding<String>,
        axis: Axis = .horizontal
    ) -> some View {
        TextField("", text: text, prompt: Text(prompt).foregroundStyle(.gray2), axis: axis)
            .font(.m18)
            .foregroundStyle(.gray6)
            .lineLimit(axis == .vertical ? 1...4 : 1...1)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.gray2, lineWidth: 2)
            }
    }
}
