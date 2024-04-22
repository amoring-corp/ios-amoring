//
//  LikesLeftView.swift
//  amoring
//
//  Created by 이준녕 on 11/30/23.
//

import SwiftUI

struct PurchasedLikesView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        let likes = userManager.user?.likesCredit ?? 0
        HStack {
            Image("ic-heart-fill")
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(14), height: Size.w(12))
            likes > 0 ?
            (Text("+") + Text(likes.description))
            : Text(likes.description)
        }
        .font(semiBold12Font)
        .foregroundColor(.yellow200)
        .padding(.vertical, 9)
        .padding(.horizontal, 14)
        .overlay(
            Capsule().stroke(Color.gray900)
        )
    }
}

#Preview {
    VStack {
        PurchasedLikesView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray1000)
}
