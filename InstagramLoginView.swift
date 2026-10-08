//
//  InstagramLoginView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/8/26.
//

import SwiftUI

struct InstagramLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.logo)
                .padding(.top, 126)
            
            TextField("이메일", text: $email, prompt: Text("이메일을 입력하세요")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray200)
            )
            .font(.system(size: 14, weight: .regular))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 15)
            .frame(height: 44)
            .background(.gray100)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.1), lineWidth: 0.5)
            }
            .padding(.horizontal, 16)
            .padding(.top, 44)
            
            SecureField("비밀번호", text: $password, prompt: Text("비밀번호를 입력하세요")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray200)
            )
            .font(.system(size: 14, weight: .regular))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal, 15)
            .frame(height: 44)
            .background(.gray100)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.1), lineWidth: 0.5)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
                        
            Button {} label: {
                Text("로그인하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.instagramBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding(.horizontal, 16)
            .padding(.top, 63)
            Spacer()
        }
    }
}
