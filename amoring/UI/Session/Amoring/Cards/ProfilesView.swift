//
//  ProfilesView.swift
//  amoring
//
//  Created by 이준녕 on 12/6/23.
//

import SwiftUI
import AmoringAPI

struct ProfilesView: View {
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var messagesController: MessagesController
    @EnvironmentObject var userManager: UserManager
    
    @Binding var selectedIndex: Int
    
    @State var isOn = false
    @State var swipeAction: SwipeAction = .doNothing
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
                        .onChange(of: isOn) { _ in
                            refresh()
                        }
                    Spacer()
                    if let gender = userManager.user?.profile?.gender, gender == .male {
                        LikesFromMaxView()
                            .onTapGesture {
                                userManager.openPurchase(purchaseType: .like)
                            }
                        if userManager.user?.likesCredit ?? 0 > 0 {
                            PurchasedLikesView()
                                .onTapGesture {
                                    userManager.openPurchase(purchaseType: .like)
                                }
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
                    Button(action: self.getProfiles) {
                        Image(systemName: "arrow.clockwise.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
                
                ForEach(userManager.profiles.indices, id:\.self) { index  in
                    let profile = userManager.profiles[index]
//
                    if (index == userManager.profiles.count - 1) {
                    SwipibleProfileVIew(profile: profile, swipeAction: $swipeAction, selectedIndex: $selectedIndex)
                    } else if (index == userManager.profiles.count - 2) {
                        GeometryReader { reader in
                            ZStack {
                                ProfileCardView(profile: profile,
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
        .onAppear(perform: getProfiles)
    }
    
    private func refresh() {
        userManager.activeCheckIn { activeCheckIn in
            if let activeCheckIn {
                userManager.getReactions { error, reactions in
                    if let error {
                        notificationController.setNotification(text: error, type: .error)
                    } else {
                        messagesController.reactions = reactions
                    }
                }
                self.getProfiles()
            }
            amoringController.checkIn = activeCheckIn
        }
    }
    
    private func getProfiles() {
        userManager.profiles.removeAll()
        
        if let checkIn = amoringController.checkIn {
            userManager.getVisibleProfiles(includeNearby: self.isOn)
//            if let profiles = checkIn.business?.activeCheckIns.map({ $0?.profile?.fragments.profileInfo }) {
//                for profile in profiles {
//                    if let profile {
//                        userManager.profiles.append(profile)
//                    }
//                }
//            }
            
            if let checkedOutAt = checkIn.checkedOutAt?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") {
//                amoringController.countDown = checkInDate.addingTimeInterval(3 * 60 * 60) - Date()
                amoringController.countDown = checkedOutAt - Date()
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { timer in
                    if let countDown = amoringController.countDown, countDown > 0 {
                        amoringController.countDown = countDown - 1
                    } else {
                        userManager.checkOutFromActive { error in
                            if let error {
                                notificationController.setNotification(text: error, type: .error)
                                self.timer?.invalidate()
                            } else {
                                amoringController.leave()
                                self.timer?.invalidate()
                            }
                        }
                    }
                })
            }
        }
    }
    
    // MARK: removed to: SwipibleProfileView
//    private func performSwipe(profile: ProfileInfo, hasLiked: Bool) {
//        withAnimation {
//            amoringController.showDetails = false
//            amoringController.hidePanel = false
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//            userManager.reactToProfile(id: profile.id, type: hasLiked ? .like : .dislike) { error, isMatched in
//                if let error {
//                    notificationController.setNotification(text: error, type: .error)
//                    // FIXME: move card back for an error [drag offset = 0]
//                } else {
//                    if isMatched {
////                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                            notificationController.setNotification(text: "새로운 인연이 생겼어요!", type: .textAndButton, action: {
//                                withAnimation {
//                                    self.selectedIndex = 2
//                                }
//                            })
//                        
//                        /// removing reaction with match from reactions list
//                        withAnimation {
//                            messagesController.reactions.removeAll(where: { $0.toProfile.id == profile.id })
//                        }
//                        
//                        userManager.getConversations { conversations in
//                            if let conversations {
//                                self.messagesController.conversations = conversations.compactMap({ Conversation(conversationInfo: $0) })
//                            }
//                        }
////                        }
//                        
//                    } else {
//                        print("NO MATHCES!")
//                    }
//                    removeTopItem()
//                    if hasLiked {
//                        if purchaseController.likes > 0 {
//                            withAnimation {
//                                purchaseController.likes -= 1
//                            }
//                        } else {
//                            withAnimation {
//                                purchaseController.purchasedLikes -= 1
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        //        onSwiped(profile, hasLiked)
//    }
    
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
