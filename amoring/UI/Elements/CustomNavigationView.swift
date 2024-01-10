//
//  CustomNavigationView.swift
//  amoring
//
//  Created by 이준녕 on 1/4/24.
//

import SwiftUI

struct CustomNavigationView: View {
    @Binding var offset: CGFloat
    let title: String
    let back: () -> Void
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    BackButton(action: back)
                    Spacer()
                }
                .padding(.horizontal, Size.w(22))
                .frame(height: 44)
                
                HStack {
                    Spacer()
                    Text(title)
                        .font(medium20Font)
                        .foregroundColor(.black)
                    Spacer()
                }
                .frame(height: 44)
                .opacity(offset / CGFloat(100))
            }
            Color.yellow200.frame(width: .infinity, height: 1).opacity(offset / CGFloat(100))
        }
        .background(Color.yellow300)
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    CustomNavigationView(title: "Spacer()", back: {})
//}
