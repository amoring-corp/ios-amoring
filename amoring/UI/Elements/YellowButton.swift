//
//  YellowButton.swift
//  amoring
//
//  Created by 이준녕 on 2/8/24.
//

import SwiftUI

struct YellowButton: View {
    var title: String
    var enabled: Bool = true
    var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView().tint(.black)
            } else {
                // "저장"
                Text(title)
            }
        }
            .font(medium18Font)
            .foregroundColor(.black)
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(65))
            .background(Color.yellow300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(enabled ? 1 : 0.3)
    }
}

#Preview {
    YellowButton(title: "NEXT")
}
