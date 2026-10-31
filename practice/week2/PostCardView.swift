//
//  PostCardView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/10/26.
//

import SwiftUI

struct PostCardView: View {
    let profileImage: Image
    let username: String
    let location: String
    let postImage: Image
    let likesText: String
    let caption: String
    let timeText: String
    
    @Binding var isLiked: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PostProfileHeaderView(profileImage: profileImage, username: "\(username)", location: "\(location)")
            
            postImages
            actionIcons
            postInformation
        }
    }
    
    
    private var postImages: some View {
        postImage
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
    
    private var actionIcons: some View {
        HStack(spacing: 18) {
            Button {
                isLiked.toggle()
            } label: {
                Image(isLiked ? "Like_fill" : "Like")
            }
            .buttonStyle(.plain)
            
            Image(.comment)
            Image(.messanger)
            
            Spacer()
            
            Image(.save)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var postInformation: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(likesText)")
            Text("\(Text("\(username)").bold()) \(caption)")
                .fixedSize(horizontal: false, vertical: true)
            Text("\(timeText)")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
        .font(.system(size: 14))
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
}
