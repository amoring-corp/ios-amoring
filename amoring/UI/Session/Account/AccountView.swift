//
//  AccountView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import CachedAsyncImage

struct AccountView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var purchaseController: PurchaseController
    
    @State private var logoutAlertPresented = false
    @State private var deleteAlertPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            Color.gray1000.frame(width: .infinity, height: 1)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    let url = userManager.user?.profile?.images.first?.file?.url ?? ""
                    
                    CachedAsyncImage(url: URL(string: url), content: { cont in
                        cont
                            .resizable()
                            .scaledToFill()
                    }, placeholder: {
                        ZStack {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }.frame(width: Size.w(64), height: Size.w(64), alignment: .center)
                    })
                    .frame(width: 64, height: 64)
//                    .frame(width: Size.w(64), height: Size.w(64))
                    .clipShape(Circle())
                    .padding(.top, Size.w(60))
                    .padding(.bottom, Size.w(30))
                    
                    HStack {
                        let gender = userManager.user?.profile?.gender.map({ $0.rawValue })
                        Text(LocalizedStringKey(gender ?? ""))
                            .font(semiBold12Font)
                            .foregroundColor(.gray1000)
                            .padding(.horizontal, Size.w(12))
                            .padding(.vertical, Size.w(6))
                            .background(Capsule().fill(Color.yellow300))
                        
                        if let age = userManager.user?.profile?.age {
                            Text(age.description + "세")
                                .font(semiBold12Font)
                                .foregroundColor(.gray1000)
                                .padding(.horizontal, Size.w(12))
                                .padding(.vertical, Size.w(6))
                                .background(Capsule().fill(Color.yellow300))
                        }
                    }
                    .padding(.bottom, Size.w(10))
                    
                    Text(userManager.user?.profile?.name ?? "")
                        .font(semiBold28Font)
                        .foregroundColor(.white)
                    
                    
                    MenuTitle(title: "내 프로필")
                        
                    VStack(spacing: 0) {
                        MenuLineLink(title: "사진") {
                            AccountPhoto()
                        }
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineLink(title: "소개글") {
                            AccountBio()
                        }
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineLink(title: "기본정보") {
                            AccountIntro()
                        }
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineLink(title: "관심사") {
                            AccountInterests()
                        }
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    
                    MenuTitle(title: "프리미엄 구매하기")
                    
                    VStack(spacing: 0) {
                        MenuLineButton(title: "+ 좋아요", subtitle: "\(purchaseController.purchasedLikes)개 남음", image: "ic-heart-fill", fontColor: Color.yellow200, subFontColor: Color.yellow350) { purchaseController.openPurchase(purchaseType: .like) }
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineButton(title: "라운지 확장", 
                                       subtitle: purchaseController.amoringCommunityIsOn ? purchaseController.communityExpiredTime().toExpiredTime() : "구매하기",
                                       fontColor: purchaseController.amoringCommunityIsOn ? Color.yellow200 : Color.gray600,
                                       subFontColor: purchaseController.amoringCommunityIsOn ? Color.yellow350 : Color.gray300)
                                       { purchaseController.openPurchase(purchaseType: .lounge) }
                                       
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineButton(title: "프로필 투명모드",
                                       subtitle: purchaseController.isHidden ? purchaseController.isHiddenExpiredTime().toExpiredTime() : "구매하기",
                                       fontColor: purchaseController.isHidden ? Color.yellow200 : Color.gray600,
                                       subFontColor: purchaseController.isHidden ? Color.yellow350 : Color.gray300)
                                       { purchaseController.openPurchase(purchaseType: .transparent) }
                                       
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineButton(title: "리스트 보기",
                                       subtitle: purchaseController.likeListEnabled ? purchaseController.likeListEnabledExpiredTime().toExpiredTime() : "구매하기",
                                       fontColor: purchaseController.likeListEnabled ? Color.yellow200 : Color.gray600,
                                       subFontColor: purchaseController.likeListEnabled ? Color.yellow350 : Color.gray300)
                                       { purchaseController.openPurchase(purchaseType: .list) }
                                       
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    MenuTitle(title: "서비스 지원")
                        
                    VStack(spacing: 0) {
                        MenuLineLink(title: "서비스 이용 약관") {
                            Text("서비스 이용 약관")
                        }
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "개인정보 보호 방침") {
                            Text("개인정보 보호 방침")
                        }
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineLink(title: "문의하기 / 신고하기") {
                            AccountEmail()
                        }
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    
                    MenuTitle(title: "내 계정")
                        
                    VStack(spacing: 0) {
                        MenuLineButton(title: "로그아웃", action: { logoutAlertPresented = true })
                            .alert("로그아웃", isPresented: $logoutAlertPresented, actions: {
                                Button("로그아웃", action: sessionManager.signOut)
                                Button("취소", role: .cancel, action: {})
                            }, message: { Text("로그아웃 하시면, 라운지 활동이나 다른 멤버로부터의 메시지 알림을 받으실 수 없습니다. 로그아웃 하시겠습니까?") })
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineButton(title: "계정 삭제", action: { deleteAlertPresented = true })
                            .alert("계정 삭제", isPresented: $deleteAlertPresented, actions: {
                                // TODO: backend. implement account deletion
                                Button("삭제", role: .destructive, action: sessionManager.signOut)
                                Button("취소", role: .cancel, action: {})
                            }, message: { Text("Amoring에서 탈퇴 시 해당 계정의 모든 정보는 영구 삭제되며 다시 복수 할 수 없습니다. Amoring 계정을 삭제하시겠습니까?") })
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    Spacer().frame(height: 200)
                    
                }
                .padding(.horizontal, Size.w(22))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(trailing: Text("").foregroundColor(.gray1000))
        }
        .background(.gray1000)
    }
}

struct MenuTitle: View {
    let title: String
    var color: Color = Color.yellow300
    var body: some View {
        Text(title)
            .font(medium18Font)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Size.w(50))
            .padding(.horizontal, Size.w(14))
            .padding(.bottom, Size.w(16))
    }
}

struct MenuLineLink<Content: View>: View {
    let title: String
    var color: Color = Color.gray600
    
    @ViewBuilder let content: Content
    
    var body: some View {
        NavigationLink(destination: { content }) {
            HStack {
                Text(title)
                    
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .font(regular16Font)
            .foregroundColor(color)
            .padding(.horizontal, Size.w(20))
            .padding(.vertical, Size.w(23))
        }
        
    }
}

struct MenuLineButton: View {
    let title: String
    var subtitle: String? = nil
    var image: String? = nil
    var fontColor: Color = Color.gray600
    var subFontColor: Color = Color.gray300
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let image {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(fontColor)
                }
                Text(title)
                    .font(regular16Font)
                    .foregroundColor(fontColor)
                Spacer()
                
                if let subtitle {
                    Text(subtitle)
                        .font(regular16Font)
                        .foregroundColor(subFontColor)
                }
                
                Image(systemName: "chevron.right")
                    .font(regular16Font)
                    .foregroundColor(.gray600)
            }
            .padding(.horizontal, Size.w(20))
            .padding(.vertical, Size.w(23))
        }
    }
}

struct MenuLineToggle: View {
    @Binding var isOn: Bool
    
    let title: String
    
    var body: some View {
            HStack {
                Text(title)
                    .font(regular16Font)
                    .foregroundColor(.yellow900)
                Spacer()
                // TODO: CUstom ?
                Toggle(isOn: $isOn) {}
                    .tint(.green400)
            }
            .padding(.horizontal, Size.w(20))
            .padding(.vertical, Size.w(14))
        }
}

#Preview {
    AccountView()
}

