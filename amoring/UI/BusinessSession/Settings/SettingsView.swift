//
//  SettingsView.swift
//  amoring
//
//  Created by 이준녕 on 11/23/23.
//

import SwiftUI
import CachedAsyncImage

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var businessSessionController: BusinessSessionController
    
    @State private var logoutAlertPresented = false
    @State private var deleteAlertPresented = false
    @State private var hasPlan = false
    
    @State private var showDistahce = false
    @State private var showNumberOfPeople = false
    @State private var showGenderRatio = false
    @State private var showMatching = false
    @State private var showAddressPicker = false
    @State private var preaddress = ""
    
    var body: some View {
        let business = userManager.user?.business
        let url = business?.images?.first?.file?.url
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    XButton(action: { presentationMode.wrappedValue.dismiss() }, color: Color.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("내 매장")
                }
                .font(medium20Font)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    CachedAsyncImage(url: URL(string: url ?? ""), content: { cont in
                        cont
                            .resizable()
                            .scaledToFill()
                    }, placeholder: {
                        ZStack {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.gray1000))
                        }
                    })
                    .frame(width: Size.w(90), height: Size.w(90))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14).stroke(Color.yellow700)
                    )
                    .padding(.top, Size.w(56))
                    .padding(.bottom, Size.w(30))
                    
                    Text(business?.businessName ?? "")
                        .font(extraBold28Font)
                        .foregroundColor(.black)
                        .padding(.bottom, Size.w(12))
                    
                    Text("\(business?.businessCategory ?? "")  |  \(business?.addressSigungu ?? "no district")")
                        .font(regular18Font)
                        .foregroundColor(.black)
                        .padding(.bottom, Size.w(50))
                    
                    
                    MenuTitle(title: "매장 프로필", color: Color.yellow700)
                    VStack(spacing: 0) {
                        MenuLineLink(title: "기본정보", color: Color.yellow900) {
                            BusinessSettingsInfo()
                        }
                        Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "영업시간", color: Color.yellow900) {
                            BusinessSettingsOpenHours()
                        }
                        Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "사진", color: Color.yellow900) {
                            BusinessSettingsImages()
                        }
                        Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "인증정보", color: Color.yellow900) {
                            BusinessSettingsCertification()
                        }
                    }
                    .background(Color.yellow200)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    MenuTitle(title: "구매 및 멤버십", color: Color.yellow700)
                    VStack(spacing: 0) {
                        MenuLineButton(title: "멤버십") {
                            withAnimation {
                                businessSessionController.showDepositInfo = true
                            }                            
                        }
                        
                        
//                        MenuLineLink(title: "멤버십", color: Color.yellow900) {
//                            DepositInfoView()
//                            if hasPlan {
//                                BusinessPlan()
//                            } else {
//                                BusinessPurchaseView()
//                            }
                            
//                        }
                        
//                            Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
//                            MenuLineToggle(isOn: $showDistahce, title: "거리 보여주기")
//                            Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
//                            MenuLineToggle(isOn: $showNumberOfPeople, title: "인원수 보여주기")
//                            Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
//                            MenuLineToggle(isOn: $showGenderRatio, title: "성비 보여주기")
//                            Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
//                            MenuLineToggle(isOn: $showMatching, title: "매칭 확률 보여주기")
                    }
                    .background(Color.yellow200)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    MenuTitle(title: "서비스 지원", color: Color.yellow700)
                    VStack(spacing: 0) {
                        MenuLineLink(title: "서비스 이용 약관", color: Color.yellow900) {
                            Text("서비스 이용 약관")
                        }
                        Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "개인정보 보호 방침", color: Color.yellow900) {
                            Text("개인정보 보호 방침")
                        }
                        Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                        MenuLineLink(title: "문의하기 / 신고하기", color: Color.yellow900) {
                            BusinessEmail()
                        }
                    }
                    .background(Color.yellow200)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    MenuTitle(title: "계정", color: Color.yellow700)
                    
                    VStack(spacing: 0) {
                        MenuLineButton(title: "로그아웃", action: { logoutAlertPresented = true }, fontColor: Color.yellow900)
                            .alert("로그아웃", isPresented: $logoutAlertPresented, actions: {
                                Button("로그아웃", action: sessionManager.signOut)
                                Button("취소", role: .cancel, action: {})
                            }, message: { Text("로그아웃 하시면, 라운지 활동이나 다른 멤버로부터의 메시지 알림을 받으실 수 없습니다. 로그아웃 하시겠습니까?") })
                        
                        Color.yellow350.frame(maxWidth: .infinity).frame(height: 1)
                        
                        MenuLineButton(title: "계정 삭제", action: { deleteAlertPresented = true }, fontColor: Color.yellow900)
                            .alert("계정 삭제", isPresented: $deleteAlertPresented, actions: {
                                // TODO: implement account deletion
                                Button("삭제", role: .destructive, action: sessionManager.signOut)
                                Button("취소", role: .cancel, action: {})
                            }, message: { Text("Amoring에서 탈퇴 시 해당 계정의 모든 정보는 영구 삭제되며 다시 복수 할 수 없습니다. Amoring 계정을 삭제하시겠습니까?") })
                    }
                    .background(Color.yellow200)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    Spacer().frame(height: 200)
                }
            }
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .navigationBarHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Text("내 매장")
//                    .font(medium20Font)
//                    .foregroundColor(.black)
//            }
//        }
//        .navigationBarItems(leading:
//                                XButton(action: { self.presentationMode.wrappedValue.dismiss() }, color: Color.black)
//        )
        
    }
}

#Preview {
    SettingsView()
}
