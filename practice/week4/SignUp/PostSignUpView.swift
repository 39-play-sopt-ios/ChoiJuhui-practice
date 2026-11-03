//
//  PostSignUpView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/31/26.
//

import SwiftUI

struct PostSignUpView: View {
    @State private var viewModel = SignupViewModel()
    let onFinish: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Group {
                TextField("web / ios / android", text: $viewModel.part)

                TextField("이름을 입력해주세요", text: $viewModel.name)
            }
            .font(.m18)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 16)
            .frame(height: 54)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color(white: 0.83), lineWidth: 2)
            }

            Button {
                Task { await viewModel.requestCode() }
            } label: {
                Text(viewModel.isLoading ? "발급 중…" : "코드 발급")
                    .font(.sb14)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 49)
                    .background(Color(.black), in: RoundedRectangle(cornerRadius: 12))
            }
            .disabled(viewModel.isLoading)
            .padding(.top, 8)

            Spacer()

            if let code = viewModel.authorizationCode {
                VStack(alignment: .leading, spacing: 8) {
                    Text("발급받은 인증 코드")
                        .font(.sb14)
                    Text(code)
                        .font(.b28)
                        .textSelection(.enabled)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 24)
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 88)
        .background(.white)
        .contentShape(.rect)
        .onTapGesture {
            guard viewModel.authorizationCode != nil else { return }
            onFinish()
        }
    }
}
