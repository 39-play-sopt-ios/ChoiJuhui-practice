//
//  RootView.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import SwiftUI

struct RootView: View {
    @State private var isAuthorized = false

    var body: some View {
        Group {
            if isAuthorized {
                NavigationStack {
                    PostListView()
                }
            } else {
                PostSignUpView {
                    isAuthorized = true
                }
            }
        }
        .animation(.easeInOut, value: isAuthorized)
    }
}
