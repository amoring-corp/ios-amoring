//
//  YellowBorderButton.swift
//  amoring
//
//  Created by Sergey Li on 4/24/24.
//

import SwiftUI

struct YellowBorderButton: View {
    let title: String
    var isLoading: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView().tint(.gray200)
                } else {
                    Text(LocalizedStringKey(title))
                }
            }
            .font(medium18Font)
            .foregroundColor(.yellow300)
            .padding(.vertical, Size.w(16))
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.yellow300)
            )
            .padding(.horizontal, 2)
        }
    }
}

#Preview {
    YellowBorderButton(title: "", action: {})
}
