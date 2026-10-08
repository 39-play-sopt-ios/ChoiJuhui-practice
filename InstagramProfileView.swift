//
//  InstagramProfileView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/8/26.
//

import SwiftUI

struct InstagramProfileView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.logo)
                .padding(.top, 193)
            
            Image(.instagramProfile)
                .resizable()
                .scaledToFill()
                .frame(width: 85, height: 85)
                .clipShape(Circle())
                .padding(.top, 65)
            
            Text("moamoa")
                .font(.system(size: 14, weight: .semibold))
                .padding(.top, 13)
            
            Button {} label: {
                Text("로그인하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.primaryBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding(.horizontal, 34)
            .padding(.top, 12)
            
            Button("계정 전환") {}
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primaryBlue)
                .padding(.top, 30)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 11) {
                Text("계정이 없으신가요?")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.gray300)
                
                Button {} label: {
                    Text("회원가입하기.")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
            .padding(.bottom, 18)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
