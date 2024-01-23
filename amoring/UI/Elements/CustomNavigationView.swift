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
    
    var foregroundColor: Color = Color.black
    var dividerColor: Color = Color.yellow200
    var bg: Color = Color.yellow300
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    BackButton(action: back, color: foregroundColor)
                    Spacer()
                }
                .padding(.horizontal, Size.w(22))
                .frame(height: 44)
                
                HStack {
                    Spacer()
                    Text(title)
                        .font(medium20Font)
                        .foregroundColor(foregroundColor)
                    Spacer()
                }
                .frame(height: 44)
                .opacity(offset / CGFloat(100))
            }
            
            dividerColor.frame(width: .infinity, height: 1).opacity(offset / CGFloat(100))
        }
        .background(bg)
        .frame(maxWidth: .infinity)
    }
}

struct CustomNavigationViewLogout: View {
    @Binding var offset: CGFloat
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Button(action: action) {
                        Text("로그아웃")
                            .font(semiBold16Font)
                            .foregroundColor(.black)
                    }
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
