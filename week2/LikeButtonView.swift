//
//  LikeButtonView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/10/26.
//

import SwiftUI

struct LikeButtonView: View {
    @Binding var isLiked: Bool

    var body: some View {
        Button {
            isLiked.toggle()
        } label: {
            Image(isLiked ? "Like_fill" : "like")
        }
    }
}
