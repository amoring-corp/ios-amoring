//
//  LikesFromMaxView.swift
//  amoring
//
//  Created by 이준녕 on 11/30/23.
//

import SwiftUI

struct LikesFromMaxView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        HStack {
            Image("ic-heart-empty")
            // TODO: better way to implement
            Text(((userManager.user?.maxLikes ?? 10) - (userManager.user?.usedLikesCount ?? 0)).description) +
            Text("/") +
            Text(String(userManager.user?.maxLikes ?? 10))
        }
        .font(semiBold12Font)
        .foregroundColor(.gray200)
        .padding(.vertical, 9)
        .padding(.horizontal, 14)
        .overlay(
            Capsule().stroke(Color.gray900)
        )
    }
}

#Preview {
    VStack {
        LikesFromMaxView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray1000)
}
