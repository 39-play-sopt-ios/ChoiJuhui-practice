//
//  InputField.swift
//  SOPT39-Seminar
//
//  Created by h2e on 10/8/26.
//

import SwiftUI

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(title, text: $text, prompt: prompt)
            } else {
                TextField(title, text: $text, prompt: prompt)
            }
        }
        .font(.system(size: 14, weight: .regular))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .padding(.horizontal, 15)
        .frame(height: 44)
        .background(.gray100)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray200, lineWidth: 0.5)
        }
    }

    private var prompt: Text {
        Text(placeholder)
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(.gray200)
    }
}
