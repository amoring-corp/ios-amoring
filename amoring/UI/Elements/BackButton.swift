//
//  BackButton.swift
//  amoring
//
//  Created by 이준녕 on 1/10/24.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    var color: Color = Color.black
    
    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(20), height: Size.w(20))
                .foregroundColor(color)
                .frame(width: 44, height: 44, alignment: .leading)
        }
    }
}

#Preview {
    BackButton(action: {})
}
