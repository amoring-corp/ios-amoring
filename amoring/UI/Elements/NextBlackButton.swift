//
//  NextBlackButton.swift
//  amoring
//
//  Created by 이준녕 on 1/2/24.
//

import SwiftUI

struct NextBlackButton: View {
    var enabled: Bool = true
    var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView().tint(.white)
            } else {
                Text("다음")
            }
        }
            .font(medium18Font)
            .foregroundColor(.gray150)
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(65))
            .background(Color.gray1000)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(enabled ? 1 : 0.3)
    }
}

struct YellowSaveButton: View {
    var enabled: Bool = true
    var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView().tint(.black)
            } else {
                Text("저장")
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

//#Preview {
//    NextBlackButton()
//}
