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
            
            InputField(title: "이메일", placeholder: "이메일을 입력하세요", text: $email)
                .padding(.horizontal, 16)
                .padding(.top, 44)

            InputField(title: "비밀번호", placeholder: "비밀번호를 입력하세요", text: $password, isSecure: true)
                .padding(.horizontal, 16)
                .padding(.top, 12)
                        
            Button {} label: {
                Text("로그인하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.primaryBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding(.horizontal, 16)
            .padding(.top, 63)
            Spacer()
        }
    }
}
