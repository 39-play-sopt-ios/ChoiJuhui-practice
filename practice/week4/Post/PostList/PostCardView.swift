//
//  PostCardView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import SwiftUI

struct PostCardView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(post.author) | \(post.createdDate)")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(post.title)
                .font(.headline)

            Text(post.content)
                .font(.subheadline)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.systemGray6), in: .rect(cornerRadius: 20))
    }
}
