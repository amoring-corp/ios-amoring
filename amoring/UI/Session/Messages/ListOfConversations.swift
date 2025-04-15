//
//  ListOfConversations.swift
//  amoring
//
//  Created by 이준녕 on 12/19/23.
//

import SwiftUI
import AmoringAPI
import Kingfisher

struct ListOfConversations: View {
    @EnvironmentObject var controller: MessagesController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var navigationController: NavigationController
    
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
                    ForEach(controller.conversations.filter { $0.archivedAt ?? Date() > Date() }.sorted(by: { $0.createdAt ?? Date() > $1.createdAt ?? Date() }), id: \.self.id) { conversation in
                        ChatRow(conversation: conversation)
                            
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .swipeActions {
                                Button(action: {
                                    alertPresented = true
                                }) {
                                    // TODO: 매치 취소하기
                                    Text("매치 취소")
//                                    Text("삭제")
                                }
                            }
                            .alertPatched(isPresented: $alertPresented) {
                                Alert(
                                    title: Text("매치 취소하기"),
                                    message: Text("매치를 취소하면 서로 연락하거나 프로필을 확인 할 수 없습니다. 매치를 취소 하시겠습니까?"),
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



#Preview {
    ListOfConversations()
}
