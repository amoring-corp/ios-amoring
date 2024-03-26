//
//  ListOfConversations.swift
//  amoring
//
//  Created by 이준녕 on 12/19/23.
//

import SwiftUI
import AmoringAPI
import CachedAsyncImage

struct ListOfConversations: View {
    @EnvironmentObject var controller: MessagesController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    
    @State var alertPresented = false
    
    /// height of bottom bar + padding
    let bottomSpacing = Size.w(75) + Size.w(16)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("메시지")
                Text("(\(controller.conversations.count))")
            }
            .font(medium18Font)
            .foregroundColor(.yellow300)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Size.w(22))
            .padding(.bottom, Size.w(20))
            
            if controller.conversations.isEmpty {
                VStack {
                    Text("연결된 인연이\n이곳에 나타납니다")
                        .font(bold26Font)
                        .foregroundColor(.gray800)
                        .lineSpacing(7)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, Size.w(16))
                    Text("라운지에서 마음에 드는 상대를 찾아보세요.\n회원님과 상대방이 서로 좋아요하면,\n이제부터 여기서 메시지를 보낼 수 있어요!")
                        .font(medium16Font)
                        .foregroundColor(.gray800)
                        .lineSpacing(6)
                        .multilineTextAlignment(.center)
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding(.bottom, bottomSpacing)
            } else {
                List {
                    ForEach(controller.conversations.filter { $0.archivedAt ?? Date() > Date() }, id: \.self.id) { conversation in
                        ChatRow(conversation: conversation)
                            .onTapGesture {
                                controller.selectedConversation = conversation
                                controller.goToConversation = true
                            }
                            .background(
                                NavigationLink(isActive: $controller.goToConversation, destination: {
                                    ConversationView()
                                }, label: { EmptyView() })
                                .isDetailLink(false)
                                .opacity(0)
                            )
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .swipeActions {
                                Button(action: {
                                    alertPresented = true
                                }) {
                                    Text("삭제")
                                }
                            }
                            .alertPatched(isPresented: $alertPresented) {
                                Alert(
                                    title: Text("메시지 삭제하기"),
                                    message: Text("메시지를 삭제하면 서로 연락하거나 프로필을 확인 할 수 없습니다.\n메시지를 삭제 하시겠습니까?"),
                                    primaryButton: .destructive(Text("삭제"), action: { delete(id: conversation.id) }),
                                    secondaryButton: .cancel(Text("취소")))
                            }
                    }
                    
                    Color.clear.frame(height: 40)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
                    
                    let archivedConversations = controller.conversations.filter { $0.archivedAt ?? Date() <= Date() }
                    
                    if !archivedConversations.isEmpty {
                        Text("아래의 메시지들은 곧 삭제됩니다.")
                            .font(regular14Font)
                            .foregroundColor(.gray700)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 22)
                            .background(Color.gray900)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 20)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                    }
                    
                    ForEach(archivedConversations, id: \.self.id) { conversation in
                        ChatRow(conversation: conversation, expired: true)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                    }
                    
                    Spacer(minLength: 200)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .padding(.top, Size.w(45))
    }
    
    private func delete(id: String) {
        userManager.deleteConversation(id: id) { error in
            if let error {
                notificationController.setNotification(text: error, type: .error)
            } else {
                controller.delete(id: id)
            }
        }
    }
}

struct ChatRow: View {
    @EnvironmentObject var userManager: UserManager
    
    let conversation: Conversation
    var expired: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            
            let user = conversation.participants.first(where: { $0.id != userManager.user?.id })
            //            let url: String? = user?.profile?.images??.first?.map({ $0.file.url ?? "" })
            let url: String? = user?.profile?.avatarUrl
            
            CachedAsyncImage(url: URL(string: url ?? ""), content: { image in
                image
                    .resizable()
                    .scaledToFill()
            }, placeholder: {ProgressView()})
            .frame(width: Size.w(64), height: Size.w(64))
            .clipShape(Circle())
            .padding(.trailing, Size.w(12))
            .blur(radius: expired ? 6 : 0)

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
                        //                            .foregroundColor(user?.isOnline ?? false ? .green300 : .red400)
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
                
                Text(conversation.messages.reversed().last?.body ?? "👋 첫인사를 보내보세요!")
                    .font(regular14Font)
                    .foregroundColor(expired ? .gray600 : (conversation.messages.isEmpty ? .yellow600 : .gray300))
                    .padding(.vertical, Size.w(6))
                
                if let archivedAt = conversation.archivedAt {
                    let eraseTime = archivedAt - Date()
                    
                    Text(eraseTime.toEraseTime())
                        .font(regular12Font)
                        .foregroundColor(.gray700)
                        .opacity(expired ? 0 : 1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
        .frame(height: Size.w(64))
        .padding(.horizontal, Size.w(22))
        .padding(.bottom, Size.w(12))
        .padding(.top, Size.w(10))
        .background(Color.gray1000.opacity(0.01))
        .opacity(expired ? 0.6 : 1)
    }
}

#Preview {
    ListOfConversations()
}
