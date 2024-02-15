//
//  ProfilesView.swift
//  amoring
//
//  Created by 이준녕 on 12/6/23.
//

import SwiftUI

struct ProfilesView: View {
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var purchaseController: PurchaseController
    @EnvironmentObject var userManager: UserManager
    
    @State var isOn = false

    @State var maxLikes: Int = 20

    
    @State var swipeAction: SwipeAction = .doNothing
//    @State var userProfiles: [UserProfile] = Dummy.userProfiles
//    @State var userProfiles: [UserProfile] = []
    @State var showAlert: Bool = false
    @State var timer: Timer? = nil
    
    //    var onSwiped: (User, Bool) -> ()
    
    
    /// height of bottom bar + padding
    let bottomSpacing = Size.w(75) + Size.w(16)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if !amoringController.hidePanel {
                HStack {
                    CoctailToggle(isOn: $isOn)
                    Spacer()
                    LikesFromMaxView(likes: amoringController.likes, maxLikes: maxLikes)
                        .onTapGesture {
                            purchaseController.openPurchase(purchaseType: .like)
                        }
                    if purchaseController.purchasedLikes > 0 {
                        PurchasedLikesView(likes: purchaseController.purchasedLikes)
                            .onTapGesture {
                                purchaseController.openPurchase(purchaseType: .like)
                            }
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 22)
                .background(Color.gray1000)
                .zIndex(2)
                .transition(.move(edge: .top))
            } else {
                if #unavailable(iOS 17) {
                    Color.gray1000.frame(height: 1).transition(.move(edge: .top))
                }
            }
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 30) {
                    Text("🙈 no more profiles")
                        .font(semiBold16Font)
                        .foregroundColor(.gray400)
                        .multilineTextAlignment(.center)
                    Button(action: {
                        userManager.getProfiles()
                    }) {
                        Image(systemName: "arrow.clockwise.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
                
                ForEach(userManager.profiles.indices, id:\.self) { index  in
                    let userProfile = userManager.profiles[index]
                    
                    if (index == userManager.profiles.count - 1) {
                        SwipibleProfileVIew(userProfile: userProfile, swipeAction: $swipeAction, onSwiped: performSwipe, likes: $amoringController.likes)
                    } else if (index == userManager.profiles.count - 2) {
                        GeometryReader { reader in
                            ZStack {
                                ProfileCardView(userProfile: userProfile,
                                                width: reader.size.width - Size.w(44),
                                                height: reader.size.height - (Size.w(75 + 56))
                                )
                                .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                            }
                            .frame(width: reader.size.width)
                            .frame(maxHeight: .infinity, alignment: .top)
                            //                            .opacity(navigator.showDetails ? 0 : 1)
                        }
                    }
                }
            }
        }
        //        .padding(.bottom, bottomSpacing)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray1000)
        .navigationBarTitleDisplayMode(.inline)

        .onAppear {
            userManager.getProfiles()
            if let checkIn = amoringController.checkIn {
                amoringController.countDown = checkIn.checkedInAt.addingTimeInterval(3 * 60 * 60) - Date()
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    if let countDown = amoringController.countDown, countDown > 0 {
                        amoringController.countDown = countDown - 1
                    } else {
                        amoringController.leave()
                    }
                })
            }
        }
    }
    
    private func performSwipe(userProfile: UserProfile, hasLiked: Bool) {
        withAnimation {
            amoringController.showDetails = false
            amoringController.hidePanel = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            removeTopItem()
            if hasLiked {
                if amoringController.likes > 0 {
                    withAnimation {
                        amoringController.likes -= 1
                    }
                } else {
                    withAnimation {
                        purchaseController.purchasedLikes -= 1
                    }
                }
            }
        }
        //        onSwiped(userProfile, hasLiked)
    }
    
    private func removeTopItem() {
        userManager.profiles.removeLast()
    }
}

//#Preview {
//    SessionView()
//}

//
//#Preview {
//    ProfilesView()
//}
