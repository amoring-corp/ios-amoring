//
//  CheckInResult.swift
//  amoring
//
//  Created by 이준녕 on 1/5/24.
//

import SwiftUI

struct CheckInResult: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var navigator: NavigationController
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var userManager: UserManager
    
    @State var hasTable = false
    @State var hasPremium = false
    
    var body: some View {
        if let resultString = navigator.resultString {
            VStack(spacing: 0){
                (
                    Text(resultString)
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
                
                Image("channel-lounge-profile")
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
                
                HStack {
                    Image(systemName: hasPremium ? "checkmark.square" : "square")
                    Text("🥂 프리미엄 라운지 회원입니다.")
                    Spacer()
                }
                .foregroundColor(.yellow350)
                .padding(Size.w(19))
                .background(Color.yellow350.opacity(hasPremium ? 0.15 : 0.01))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    !hasPremium ?
                    RoundedRectangle(cornerRadius: 10).stroke(Color.yellow700) : nil
                )
                .onTapGesture {
                    withAnimation {
                        self.hasPremium.toggle()
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: Size.w(22)) {
                    Button(action: {
                        withAnimation {
                            amoringController.checkIn = nil
                            navigator.toRoot()
                            navigator.resultString = nil
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
                            //                            // TODO: pass business id here
                            amoringController.checkIn = CheckIn(userId: userManager.user?.id, businessId: resultString, place: resultString, checkedInAt: Date(), checkedOutAt: nil)
                            self.presentationMode.wrappedValue.dismiss()
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
            .navigationBarItems(trailing:
                                    Button(action: {
                
            }) {
                Image("ic-info")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(32), height: Size.w(32))
            }
            )
        }
    }
}

//#Preview {
//    CheckInResult()
//}
