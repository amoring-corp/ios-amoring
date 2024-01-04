//
//  NextBlackButton.swift
//  amoring
//
//  Created by 이준녕 on 1/2/24.
//

import SwiftUI

struct NextBlackButton: View {
    var enabled: Bool = true
    
    var body: some View {
        Text("다음")
            .font(medium18Font)
            .foregroundColor(.gray150)
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(65))
            .background(Color.gray1000)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(enabled ? 1 : 0.3)
    }
}

//#Preview {
//    NextBlackButton()
//}
