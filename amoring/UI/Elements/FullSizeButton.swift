//
//  FullSizeButton.swift
//  amoring
//
//  Created by 이준녕 on 1/4/24.
//

import SwiftUI

struct FullSizeButton: View {
    let title: String
    var color: Color = .gray150
    var bg: Color = Color.gray1000
    var enabled: Bool = true
    var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView().tint(.white)
            } else {
                Text(title)
            }
        }
        .font(medium18Font)
        .foregroundColor(color)
        .padding(.vertical, Size.w(16))
        .frame(maxWidth: .infinity)
        .background(bg)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .opacity(enabled ? 1 : 0.3)
    }
}

#Preview {
    FullSizeButton(title: "", enabled: true)
}
