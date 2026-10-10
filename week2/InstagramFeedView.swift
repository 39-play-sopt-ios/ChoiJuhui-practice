//
//  InstagramFeedView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/10/26.
//

import SwiftUI

struct InstagramFeedView: View {
    @State private var posts: [PostModel] = examplePosts
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 19) {
                Image(.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 107, height: 24)
                
                ForEach($posts) { $post in
                    PostCardView(
                        profileImage: Image(post.profileImageName),
                        username: post.username,
                        location: post.location,
                        postImage: Image(post.postImageName),
                        likesText: post.likesText,
                        caption: post.caption,
                        timeText: post.timeText,
                        isLiked: $post.isLiked
                    )
                }
            }
        }
    }
}

//#Preview {
//    InstagramFeedView()
//}
