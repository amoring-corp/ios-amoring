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
    @EnvironmentObject var sessionController: SessionController
    
    @State private var pictures: [PictureModel] = []
    
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var bio: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    let url = userManager.user?.userProfile?.images.first?.file?.url ?? ""
                    
                    CachedAsyncImage(url: URL(string: url), content: { cont in
                        cont
                            .resizable()
                            .scaledToFill()
                    }, placeholder: {
                        ZStack {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }.frame(width: Size.w(64), height: Size.w(64), alignment: .center)
                    })
                    .frame(width: Size.w(64), height: Size.w(64))
                    .clipShape(Circle())
                    .padding(.top, Size.w(16))
                    .padding(.bottom, Size.w(30))
                    
                    HStack {
                        Text(LocalizedStringKey(userManager.user?.userProfile?.gender ?? ""))
                            .font(semiBold12Font)
                            .foregroundColor(.gray1000)
                            .padding(.horizontal, Size.w(12))
                            .padding(.vertical, Size.w(6))
                            .background(Capsule().fill(Color.yellow300))
                        
                        if let age = userManager.user?.userProfile?.age {
                            Text(age.description + "세")
                                .font(semiBold12Font)
                                .foregroundColor(.gray1000)
                                .padding(.horizontal, Size.w(12))
                                .padding(.vertical, Size.w(6))
                                .background(Capsule().fill(Color.yellow300))
                        }
                    }
                    .padding(.bottom, Size.w(10))
                    
                    Text(userManager.user?.userProfile?.name ?? "")
                        .font(semiBold28Font)
                        .foregroundColor(.white)
                    
                    
                    MenuTitle(title: "내 프로필")
                        
                    VStack(spacing: 0) {
                        MenuLineLink(title: "사진") {
                            Text("Photos")
                        }
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "소개글") {
                            Text("소개글")
                        }
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "기본정보") {
                            Text("기본정보")
                        }
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "관심사") {
                            Text("관심사")
                        }
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    
                    MenuTitle(title: "프리미엄 구매하기")
                    
                    VStack(spacing: 0) {
                        MenuLineButton(title: "+ 좋아요", subtitle: "\(sessionController.purchasedLikes)개 남음", image: "ic-heart-fill", action: { sessionController.openPurchase(purchaseType: .like) }, fontColor: Color.yellow200, subFontColor: Color.yellow350)
                        
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineButton(title: "라운지 확장", subtitle: "구매하기", action: { sessionController.openPurchase(purchaseType: .lounge) })
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        // TODO: pu real time here
                        MenuLineButton(title: "프로필 투명모드", subtitle: "11시간 59 분 남음", action: { sessionController.openPurchase(purchaseType: .transparent) }, fontColor: Color.yellow200, subFontColor: Color.yellow350)
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineButton(title: "리스트 보기", subtitle: "구매하기", action: { sessionController.openPurchase(purchaseType: .list) })
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
                            Text("문의하기 / 신고하기")
                        }
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    
                    MenuTitle(title: "내 계정")
                        
                    VStack(spacing: 0) {
                        MenuLineButton(title: "로그아웃", action: sessionManager.signOut)
                        Color.gray1000.frame(maxWidth: .infinity).frame(height: 1)
                        // TODO: implement account deletion
                        MenuLineButton(title: "계정 삭제", action: sessionManager.signOut)
                    }
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    Spacer().frame(height: 200)
                    
//                    PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
//                        confirmRemoveImageIndex = index
//                        showRemoveConfirmation.toggle()
//                    }, onAddImageClick: {
//                        showContentTypeSheet.toggle()
//                    })
//                    .padding(.horizontal)
//                    .sheet(isPresented: $showContentTypeSheet) {
//                        ImagePicker(pictures: $pictures).ignoresSafeArea()
//                    }
//                    //            .alert("camera-permission-denied", isPresented: $showPermissionDenied, actions: {}, message: { Text("user-must-grant-camera-permission") })
//                    .alert("Remove this picture?", isPresented: $showRemoveConfirmation, actions: {
//                        Button("Yes", action: removePicture)
//                        Button("Cancel", role: .cancel, action: {})
//                    })
                }
                .padding(.horizontal, Size.w(22))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray1000)
        }
    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
}

struct MenuTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(medium18Font)
            .foregroundColor(.yellow300)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Size.w(50))
            .padding(.horizontal, Size.w(14))
            .padding(.bottom, Size.w(16))
    }
}

struct MenuLineLink<Content: View>: View {
    let title: String
    
    @ViewBuilder let content: Content
    
    var body: some View {
        NavigationLink(destination: { content }) {
            HStack {
                Text(title)
                    
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .font(regular16Font)
            .foregroundColor(.gray600)
            .padding(.horizontal, Size.w(20))
            .padding(.vertical, Size.w(23))
        }
        
    }
}

struct MenuLineButton: View {
    let title: String
    var subtitle: String? = nil
    var image: String? = nil
    let action: () -> Void
    var fontColor: Color = Color.gray600
    var subFontColor: Color = Color.gray300
    
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

#Preview {
    AccountView()
}

