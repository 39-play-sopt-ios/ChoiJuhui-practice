//
//  FloatingAddButton.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import SwiftUI

struct FloatingAddButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.shape)
                .foregroundStyle(.white)
                .frame(width: 60, height: 60)
                .background(.networkRed, in: .circle)
        }
    }
}
