//
//  PostProfileHeaderView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/10/26.
//

import SwiftUI

struct PostProfileHeaderView: View {
    let profileImage: Image
    let username: String
    let location: String
    
    var body: some View {
        HStack(spacing: 10) {
            profileImage
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 1) {
                Text("\(username)")
                    .font(.system(size: 13, weight: .semibold))
                Text("\(location)")
                    .font(.system(size: 11, weight: .regular))
            }
            Spacer()
            
            Image(.moreIcon)
                .resizable()
                .scaledToFill()
                .frame(width: 14, height: 3)
                .clipShape(Circle())
        }
        .padding(.leading, 10)
        .padding(.vertical, 10)
    }
}
