//
//  BorderButton.swift
//  amoring
//
//  Created by 이준녕 on 1/23/24.
//

import SwiftUI

struct BorderButton: View {
    let title: String
    var color: Color = .yellow300
    var borderColor: Color = .yellow300
    var enabled: Bool = true
    var isLoading: Bool = false
    var loadingColor: Color = Color.white
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView().tint(loadingColor)
            } else {
                Text(title)
            }
        }
        .font(medium18Font)
        .foregroundColor(color)
        .padding(.vertical, Size.w(16))
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(borderColor)
        )
        .opacity(enabled ? 1 : 0.3)
    }
}

#Preview {
    BorderButton(title: "BorderButton")
}
