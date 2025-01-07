//
//  CheckInResult.swift
//  amoring
//
//  Created by 이준녕 on 1/5/24.
//

import SwiftUI
import Kingfisher

struct CheckInResult: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var messagesController: MessagesController
    
    @State var hasTable = false
    @State var hasPremium = false
    
    let businessName: String
    let id: String
    var image: String?
    
    var body: some View {
        //        if let resultString = navigator.resultString {
        VStack(spacing: 0){
            (
                Text(businessName)
                    .font(extraBold28Font)
                    .foregroundColor(.yellow200)
                +
                Text(" 의")
                    .font(regular28Font)
                    .foregroundColor(.yellow300)
            )
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.top, Size.w(32))
            
            Text("라운지에 체크인 하시겠습니까?")
                .font(regular16Font)
                .foregroundColor(.yellow300)
                .padding(.top, Size.w(12))
            
            
            
            let url = URL(string: image ?? "")

            KFImage.url(url)
                .resizable()
                .placeholder {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                }
                .fade(duration: 1)
                .cancelOnDisappear(true)
                .aspectRatio(contentMode: .fill)
            
//            CachedAsyncImage(url: URL(string: image ?? ""), content: { cont in
//                cont
//                    .resizable()
//                    .scaledToFill()
//            }, placeholder: {
//                ZStack {
//                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
//                }
//            })
            .frame(width: Size.w(90), height: Size.w(90))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14).stroke(Color.yellow700)
            )
            .padding(Size.w(40))
            
            HStack {
                Image(systemName: hasTable ? "checkmark.square" : "square")
                Text("🍸 테이블이 있습니다.")
                Spacer()
            }
            .foregroundColor(.green200)
            .padding(Size.w(19))
            .background(Color.green300.opacity(hasTable ? 0.15 : 0.01))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                !hasTable ?
                RoundedRectangle(cornerRadius: 10).stroke(Color.green700) : nil
            )
            .padding(.bottom, Size.w(12))
            .onTapGesture {
                withAnimation {
                    self.hasTable.toggle()
                }
            }
            
            //                HStack {
            //                    Image(systemName: hasPremium ? "checkmark.square" : "square")
            //                    Text("🥂 프리미엄 라운지 회원입니다.")
            //                    Spacer()
            //                }
            //                .foregroundColor(.yellow350)
            //                .padding(Size.w(19))
            //                .background(Color.yellow350.opacity(hasPremium ? 0.15 : 0.01))
            //                .clipShape(RoundedRectangle(cornerRadius: 10))
            //                .overlay(
            //                    !hasPremium ?
            //                    RoundedRectangle(cornerRadius: 10).stroke(Color.yellow700) : nil
            //                )
            //                .onTapGesture {
            //                    withAnimation {
            //                        self.hasPremium.toggle()
            //                    }
            //                }
            
            Spacer()
            
            HStack(alignment: .center, spacing: Size.w(22)) {
                Button(action: {
                    withAnimation {
                        amoringController.checkIn = nil
                        self.presentationMode.wrappedValue.dismiss()
                        //                            navigator.resultString = nil
                    }
                }) {
                    Text("아니요")
                        .font(medium18Font)
                        .foregroundColor(.yellow600)
                        .padding(.vertical, Size.w(16))
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.yellow600)
                        )
                }
                
                Button(action: {
                    withAnimation {
                        userManager.updateCheckInStatus(id: id, hasTable: hasTable) { error, checkIn in
                            if let error {
                                notificationController.setNotification(text: error, type: .error)
                            }
                            if let checkIn {
                                userManager.getReactions { error, reactions in
                                    if let error {
                                        notificationController.setNotification(text: error, type: .error)
                                    } else {
                                        messagesController.reactions = reactions
                                    }
                                }
                                print(checkIn)
                                DispatchQueue.main.async {
                                    amoringController.checkIn = checkIn
                                }
                                
                                //                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }) {
                    Text("네")
                        .font(medium18Font)
                        .foregroundColor(.gray1000)
                        .padding(.vertical, Size.w(16))
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
        }
        .padding(.horizontal, Size.w(22))
        .padding(.bottom, Size.w(36))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray1000)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("AMORING")
                    .font(bold20Font)
                    .foregroundColor(.yellow300)
            }
        }
//        .navigationBarItems(trailing:
//                                Button(action: {
//            
//        }) {
//            Image("ic-info")
//                .resizable()
//                .scaledToFit()
//                .frame(width: Size.w(32), height: Size.w(32))
//        }
//        )
        //        }
    }
}

//#Preview {
//    CheckInResult()
//}
