//
//  LikeDislikeButtons.swift
//  amoring
//
//  Created by 이준녕 on 12/13/23.
//

import SwiftUI

struct LikeDisLikeButtons: View {
    @Binding var swipeAction: SwipeAction
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    swipeAction = .swipeLeft
                }) {
                    ZStack {
                        Circle().frame(width: Size.w(76), height: Size.w(76))
                            .foregroundColor(.gray900)
                        Image("dislike-cross")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Size.w(29), height: Size.w(29))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    swipeAction = .swipeRight
                }) {
                    ZStack {
                        Circle().frame(width: Size.w(76), height: Size.w(76))
                            .foregroundColor(.gray900)
                        Image("ic-heart-fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Size.w(34), height: Size.w(30))
                            .foregroundColor(.yellow300)
                    }
                }
            }
            .padding(.horizontal, Size.w(44 + 22))
            .zIndex(2)
            /// bottom bar and 16padding
            .padding(.bottom, Size.w(75 + 16))
        }
        
    }
}
