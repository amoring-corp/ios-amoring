//
//  ListOfPeopleLikesLink.swift
//  amoring
//
//  Created by 이준녕 on 12/19/23.
//

import SwiftUI

struct ListOfPeopleLikesLink: View {
    @EnvironmentObject var navigator: NavigationsMessagesController
    @EnvironmentObject var sessionController: SessionController
    
    var body: some View {
        var listIsEnable = sessionController.likeListEnabled
        
        VStack(alignment: .leading, spacing: Size.w(14)) {
            Text("리스트")
                .font(medium18Font)
                .foregroundColor(.yellow300)
                .padding(.horizontal, Size.w(22))
            
            ZStack(alignment: .bottom) {
                if listIsEnable {
                    LinearGradient(colors: likeGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                        .frame(height: Size.w(68))
                }
                
                HStack {
                    ZStack(alignment: .topLeading) {
                        Image("person-0")
                            .resizable()
                            .blur(radius: listIsEnable ? 0 : 6)
                            .scaledToFill()
                            .frame(width: Size.w(73), height: Size.w(98))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .padding(2)
                            .background(Color.gray1000)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .rotationEffect(.degrees(7), anchor: .bottomLeading)
                            .offset(x: Size.w(15))
                        
                        Image("person-1")
                            .resizable()
                            .blur(radius: listIsEnable ? 0 : 6)
                            .scaledToFill()
                            .frame(width: Size.w(73), height: Size.w(98))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .padding(2)
                            .background(Color.gray1000)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        ZStack {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("리스트 보기")
                            }
                            .font(semiBold12Font)
                            .foregroundColor(.yellow200)
                            .padding(.horizontal, Size.w(14))
                            .padding(.vertical, Size.w(9))
                            .background(Color.gray1000)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.gray900, lineWidth: 1))
                        }
                        .frame(width: Size.w(113), height: Size.w(114), alignment: .bottomTrailing)
                    }
                    .frame(width: Size.w(113), height: Size.w(114), alignment: .topLeading)
                    .padding(.trailing, Size.w(12))
                    
                    VStack(alignment: .leading) {
                        Text(listIsEnable ?  "이제, 좋아요한 라운지 멤버를 확인하고\n먼저 메시지를 보내보세요!" : "리스트에는 회원님을 좋아요한\n라운지 멤버들이 모두 나타납니다.")
                            .font(listIsEnable ? medium14Font : light14Font)
                            .foregroundColor(listIsEnable ? .black : .gray400)
                            .lineSpacing(6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, Size.w(12))
                        
                        if !listIsEnable {
                            Text("리스트 확인하기 >")
                                .font(medium14Font)
                                .foregroundColor(.gray600)
                                .frame(height: Size.w(32))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .frame(height: Size.w(114), alignment: .bottom)
                }
                .padding(.horizontal, Size.w(22))
                .padding(.bottom, Size.w(4))
            }
            .frame(height: Size.w(118), alignment: .bottom)
        }
        .padding(.top, Size.w(16))
        .padding(.bottom, Size.w(45))
        .background(Color.gray1000)
        .onTapGesture {
            navigator.path.append(MessagesPath.list)
        }
    }
}

#Preview {
    ListOfPeopleLikesLink()
}
