//
//  ConfirmAlert.swift
//  SOPT39-Seminar
//
//  Created by h2e on 11/4/26.
//

import SwiftUI

struct ConfirmAlertModifier<Item>: ViewModifier {
    @Binding var item: Item?
    let message: String
    let confirmTitle: String
    let onConfirm: (Item) -> Void

    func body(content: Content) -> some View {
        content
            .overlay {
                if let presentedItem = item {
                    ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture { item = nil }

                        VStack(spacing: 20) {
                            Text(message)
                                .font(.subhead2)
                                .foregroundStyle(.black)

                            HStack(spacing: 8) {
                                Button {
                                    item = nil
                                } label: {
                                    Text("취소")
                                        .font(.subhead2)
                                        .foregroundStyle(.gray5)
                                        .frame(maxWidth: .infinity, minHeight: 44)
                                        .background(.gray100, in: .capsule)
                                }

                                Button {
                                    item = nil
                                    onConfirm(presentedItem)
                                } label: {
                                    Text(confirmTitle)
                                        .font(.subhead2)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity, minHeight: 44)
                                        .background(.black, in: .capsule)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.top, 24)
                        .padding([.horizontal, .bottom], 16)
                        .background(.white, in: .rect(cornerRadius: 16))
                        .padding(.horizontal, 40)
                    }
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: item != nil)
    }
}

extension View {
    func confirmAlert<Item>(
        item: Binding<Item?>,
        message: String,
        confirmTitle: String = "확인",
        onConfirm: @escaping (Item) -> Void
    ) -> some View {
        modifier(ConfirmAlertModifier(
            item: item,
            message: message,
            confirmTitle: confirmTitle,
            onConfirm: onConfirm
        ))
    }
}
