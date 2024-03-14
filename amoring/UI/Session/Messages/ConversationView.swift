//
//  ConversationView.swift
//  amoring
//
//  Created by 이준녕 on 12/19/23.
//

import SwiftUI
import AmoringAPI

struct ConversationView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var controller: MessagesController
    @EnvironmentObject var notificationController: NotificationController
    @State var newMessage = ""
    @State var controlPresented = false
    @State var alertPresented = false
    
    var body: some View {
        if let conversation = controller.selectedConversation {
            let companion = conversation.participants.first(where: { $0.id != userManager.user?.id })
            
            ScrollViewReader { proxy in
                ZStack(alignment: .bottom) {
                    ScrollView {
                        header()
                        
                        if conversation.messages.isEmpty {
                            VStack(spacing: Size.w(15)) {
                                Image("wine-two")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: Size.w(90), height: Size.w(90))
                                
                                Text("메시지를 시작할 수 있어요!")
                                    .font(medium22Font)
                                    .foregroundColor(.gray500)
                                
                                Text("서로 좋아요한 상대방과\n이제부터 여기서 메시지를 보낼 수 있어요.\n먼저 메시지를 보내보세요!")
                                    .font(medium16Font)
                                    .foregroundColor(.gray600)
                                    .lineSpacing(6)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, Size.w(50))
                        } else {
                            ForEach(conversation.messages.reversed(), id: \.self) { message in
                                MessageView(message: message)
                                    .id(message.id)
                            }
                        }
                        /// do not remove this dublicate button. Bug: iOS 15,16 - no top bar while scrolling
                        messageField(proxy: proxy).opacity(0.01).disabled(true).id("bottom")
                    }
                    
                    .onAppear {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                    .onReceive(keyboardPublisher) { isKeyboardVisible in
                        if isKeyboardVisible {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation {
                                    proxy.scrollTo("bottom", anchor: .bottom)
                                    //                                    proxy.scrollTo(messages.last?.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .onChange(of: userManager.newMessage) { newMessage in
                        // MARK: New message from subscription
                        //                    if let newMessage, newMessage.senderId == companion?.id {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            withAnimation {
                                proxy.scrollTo("bottom", anchor: .bottom)
                            }
                        }
                        //                    }
                    }
                    .onDisappear {
                        DispatchQueue.main.async {
                            controller.selectedConversation = nil
                            controller.goToConversation = false
                        }
                    }
                    
                    messageField(proxy: proxy)
                        .alert(isPresented: $alertPresented) {
                            Alert(title: Text("신고하기"), message: Text("이 메시지 내역 또는 멤버가 신고 대상에 해당하는지 다시 한번 확인해주세요. 신고 시 사실확인을 위한 내역이 관리자에게 전달됩니다."), primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("보내기"), action: { controller.report() }))
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray1000)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(companion?.profile?.name ?? "")
                        .font(medium20Font)
                        .foregroundColor(.yellow300)
                }
            }
            .navigationBarItems(leading:
                                    BackButton(action: {
                presentationMode.wrappedValue.dismiss()
//                controller.selectedConversation = nil
//                controller.goToConversation = false
            }, color: Color.yellow300)
                                , trailing:
                                    Button(action: {
                controlPresented = true
            }) {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(20), height: Size.w(20))
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.yellow300)
            }
                .confirmationDialog("", isPresented: $controlPresented, titleVisibility: .hidden) {
                    Button("삭제") {
                        presentationMode.wrappedValue.dismiss()
                        controller.delete(id: conversation.id)
                    }
                    Button("신고하기") {
                        alertPresented = true
                    }
                    Button("취소", role: .cancel) {
                    }
                }
            )
        }
    }
    
    func sendMessage(_ proxy: ScrollViewProxy) {
        if !newMessage.isEmpty, let conversation = controller.selectedConversation {
            userManager.sendMessage(body: newMessage, id: conversation.id) { error, message in
                if let error {
                    notificationController.setNotification(text: error, type: .error)
                } else if let message {
                    DispatchQueue.main.async {
                        withAnimation {
                            if let row = self.controller.conversations.firstIndex(where: { $0.id == message.conversationId }) {
                                self.controller.conversations[row].messages.insert(Message(messageInfo: message), at: 0)
                                if let selectedConversation = controller.selectedConversation {
                                    self.controller.selectedConversation?.messages.insert(Message(messageInfo: message), at: 0)
                                }
                            }
                            newMessage = ""
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        let companion = controller.selectedConversation?.participants.first(where: { $0.id != userManager.user?.id })
        let url = companion?.profile?.images.first?.file?.url ?? ""
        
        VStack {
            AsyncImage(url: URL(string: url), content: { image in
                image
                    .resizable()
                    .scaledToFill()
            }, placeholder: {ProgressView()})
            .frame(width: Size.w(64), height: Size.w(64))
            .clipShape(Circle())
            .padding(.top, Size.w(30))
            
            VStack(spacing: 10) {
                Text("강남, Channel")
                    .foregroundColor(.yellow300)
                + Text(" 에서")
                    .foregroundColor(.gray500)
                
                let diff = Date() - (controller.selectedConversation?.createdAt ?? Date())
//                let endTime: TimeInterval = 24 * 60 * 60
                
                Text(diff.toPassedTime())
                    .foregroundColor(.yellow300)
                + Text(" 에 메시지가 활성화 되었습니다.")
                    .foregroundColor(.gray500)
            }
            .font(regular14Font)
            .padding(.bottom, Size.w(15))
            
            Divider()
                .padding(.bottom, Size.w(50))
        }
    }
    
    @ViewBuilder
    func messageField(proxy: ScrollViewProxy) -> some View {
        VStack {
            Divider()
            
            ZStack {
                HStack {
                    // TODO: TextEditor ?
                    TextField("메세지를 입력하세요.", text: $newMessage)
                        .onSubmit {
                            sendMessage(proxy)
                        }
                    
                    Button(action: {
                        sendMessage(proxy)
                    }) {
                        Image("send-button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Size.w(24), height: Size.w(24))
                    }
                    .opacity(newMessage.isEmpty ? 0 : 1)
                }
            }
            .padding(.horizontal, Size.w(19))
            .padding(.vertical, Size.w(12))
            .background(Color.gray900)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25).stroke(Color.gray800)
            )
            .padding(.horizontal, Size.w(22))
            .padding(.bottom, Size.w(12))
            .padding(.top, Size.w(10))
        }
        .background(Color.gray1000)
    }
}

struct MessageView: View {
    @EnvironmentObject var userManager: UserManager
    let message: Message
    
    var body: some View {
        let isOwner = message.senderId == userManager.user?.id
        
        if isOwner {
            HStack(alignment: .bottom) {
                Text(message.createdAt?.toHM() ?? "")
                    .font(light12Font)
                    .foregroundColor(.gray400)

                Text(message.body)
                    .foregroundColor(.gray900)
                    .padding()
                    .background(Color.yellow200)
                    .cornerRadius(16, corners: [.bottomLeft, .topLeft, .topRight])
            }
            .padding(.horizontal, Size.w(22))
            
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(12))
        } else {
            HStack(alignment: .bottom) {
                Text(message.body)
                    .foregroundColor(.gray900)
                    .padding()
                    .background(Color.gray150)
                    .cornerRadius(16, corners: [.bottomRight, .topLeft, .topRight])
                
                Text(message.createdAt?.toHM() ?? "")
                    .font(light12Font)
                    .foregroundColor(.gray400)
            }
            .padding(.horizontal, Size.w(22))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, Size.w(12))
        }
    }
}

//#Preview {
//    ConversationView()
//}
