//
//  ChatCardView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/17/26.
//

import SwiftUI

struct ChatCardView: View {
        let profile: Image
        let nickname: String
        let text: String
        let time: String
    
    var body: some View {
        HStack {
            profileImage
            caption
            
            Spacer()
            
            timeText
            camera
        }
        .frame(maxWidth: .infinity)
    }
    
    private var profileImage: some View {
        profile
            .resizable()
            .scaledToFit()
            .frame(width: 56, height: 56)
            .clipShape(Circle())
    }
    
    private var caption: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(nickname)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.black)
            Text(text)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.gray300)
        }
        .padding(.leading, 12)
        .padding(.vertical, 20)
    }
    
    private var timeText: some View {
        VStack {
            Text(time)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.gray300)
        }
        .padding(.top, 37)
        .padding(.bottom, 19)
    }
    
    private var camera: some View {
        Image(.picture)
            .resizable()
            .scaledToFill()
            .frame(width: 23, height: 22)
            .padding(.top, 24)
            .padding(.leading, 32)
            .padding(.trailing, 16)
    }
}
