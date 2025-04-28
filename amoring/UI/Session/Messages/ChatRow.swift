//
//  ChatRow.swift
//  amoring
//
//  Created by Sergey on 4/15/25.
//

import SwiftUI
import AmoringAPI
import Kingfisher

struct ChatRow: View {
    @EnvironmentObject var controller: MessagesController
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var navigationController: NavigationController
    
    let conversation: Conversation
    var expired: Bool = false
    
    @State var isOnline: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            
            let user = conversation.participants.first(where: { $0.id != userManager.user?.id })
            //            let url: String? = user?.profile?.images??.first?.map({ $0.file.url ?? "" })
            let urlString: String? = user?.profile?.avatarUrl
//            let business = controller.selectedConversation?.checkIns.first(where: { $0.profileId != userManager.user?.profile?.id })?.business
            let url = URL(string: urlString ?? "")

            KFImage.url(url)
                .resizable()
                .placeholder {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                }
                .fade(duration: 1)
                .cancelOnDisappear(true)
                .aspectRatio(contentMode: .fill)
//            CachedAsyncImage(url: URL(string: url ?? ""), content: { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//            }, placeholder: {ProgressView()})
            .frame(width: Size.w(64), height: Size.w(64))
            .clipShape(Circle())
            .padding(.trailing, Size.w(12))
            .blur(radius: expired ? 6 : 0)
            .background(Color.gray100.opacity(0.01))
            .onTapGesture {
//                if business != nil, let profile = user?.profile {
                DispatchQueue.main.async {
                    if let profile = user?.profile?.fragments.profileInfo {
                   
                        navigationController.selectedProfile = profile
    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            navigationController.goToUserDetailsFromList = true
    //                    }
                    }
                }
            }
            
            
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(user?.profile?.name ?? "")
                        .font(medium16Font)
                        .foregroundColor(expired ? .gray600 : .gray300)
                    if expired {
                        Circle().stroke(Color.gray300)
                            .frame(width: Size.w(6), height: Size.w(6))
                    } else {
                        Circle().fill()
                            .foregroundColor(self.isOnline ? .green300 : .red400)
                            .frame(width: Size.w(6), height: Size.w(6))
                    }
                    
                    Spacer()
                    
                    if conversation.messages.isEmpty {
                        Text("New")
                            .font(semiBold12Font)
                            .foregroundColor(.black)
                            .padding(.vertical, Size.w(8))
                            .padding(.horizontal, Size.w(10))
                            .background(Color.yellow300)
                            .clipShape(Capsule())
                    } else {
                        if let createdAt = conversation.messages.reversed().last?.createdAt {
                            let diff = Date() - createdAt
                            Text(diff.toPassedTime())
                                .font(regular14Font)
                                .foregroundColor(expired ? .gray600 : (diff > 61 ? .gray700 : .yellow300))
                        }
                    }
                }
                
                Text(conversation.messages.reversed().last?.body ?? NSLocalizedString("👋 첫인사를 보내보세요!", comment: ""))
                    .font(regular14Font)
                    .foregroundColor(expired ? .gray600 : (conversation.messages.isEmpty ? .yellow600 : .gray300))
                    .padding(.vertical, Size.w(6))
                
                if let archivedAt = conversation.archivedAt {
                    let eraseTime = archivedAt - Date()
                    Text(String(format: NSLocalizedString("%d시간 후 메시지가 사라집니다.", comment: ""), eraseTime.toEraseTime()))
                        .font(regular12Font)
                        .foregroundColor(.gray700)
                        .opacity(expired ? 0 : 1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .contentShape(Rectangle())
            .onTapGesture {
//                print("on tap")
                DispatchQueue.main.async {
                    controller.selectedConversation = conversation
                    controller.goToConversation = true
                }
//                print("on tap 2")
            }
            .background(
                NavigationLink(isActive: $controller.goToConversation, destination: {
                    ConversationView()
                        .onAppear(perform: navigationController.hideBar)
                        .onDisappear(perform: navigationController.showBar)
                }, label: { EmptyView() })
                .isDetailLink(false)
                .opacity(0)
            )
            .background(
                Group {
                    if let selectedProfile = navigationController.selectedProfile {
                        NavigationLink(isActive: $navigationController.goToUserDetailsFromList, destination: {
                            ProfileDetailsView(profile: selectedProfile)
                        }
                                       , label: { EmptyView() })
                        .isDetailLink(false)
                        .opacity(0)
                    }
                }
            )
        }
        .frame(height: Size.w(64))
        .padding(.horizontal, Size.w(22))
        .padding(.bottom, Size.w(12))
        .padding(.top, Size.w(10))
        .background(Color.gray1000.opacity(0.01))
        .opacity(expired ? 0.6 : 1)
        .onAppear {
            DispatchQueue.once(token: sessionManager.sessionToken) {
                self.isOnline = conversation.participants.first(where: { $0.id != userManager.user?.id })?.profile?.isOnline ?? false
            }
        }
        .onChange(of: userManager.statusChanged) { newStatus in
            if let newStatus {
                if newStatus.id == conversation.participants.first(where: { $0.id != userManager.user?.id })?.profile?.id {
                    self.isOnline = newStatus.isOnline
                }
            }
        }
    }
}
