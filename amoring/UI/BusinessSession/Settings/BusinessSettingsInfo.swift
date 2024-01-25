//
//  BusinessSettingsInfo.swift
//  amoring
//
//  Created by 이준녕 on 1/24/24.
//

import SwiftUI

struct BusinessSettingsInfo: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    

    @State var businessCategory: String = "클럽"
    @State var phoneNumber: String = ""
    @State var bio: String = ""
    
    @State var typesSheetPresented: Bool = false
    @State var showPhoneCodes = false
    @State var selectedCode: String = "010"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: .constant(400), title: "기본정보", back: { presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: .constant(400)) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("아래의 내용은 비울 수 없습니다\n고객에게 홍보되는 정보이니 정확히 작성해주세요.")
                            .font(regular16Font)
                            .foregroundColor(.yellow600)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(40))
                            .padding(.bottom, Size.w(40))
                        
                            PickerButton(title: "분류*") {
                                    Text(businessCategory)
                                        .foregroundColor(.black)
                                        .font(medium18Font)
                                
                            }
                            .onTapGesture {
                                withAnimation {
                                    typesSheetPresented.toggle()
                                }
                            }
//                        }
                        .padding(.bottom, Size.w(30))

                        VStack(alignment: .leading) {
                            Text("매장소개* (150자 이하)")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                                .onChange(of: bio, perform: { newValue in
                                    if(newValue.count >= 150){
                                        bio = String(newValue.prefix(150))
                                    }
                                })
                            
                            MultilineCustomTextField(placeholder: "고객들이 회원님의 매장을 잘 이해할 수 있도록 간단한 소개 부탁드립니다. 소개는 150자 이하로 부탁드립니다.", text: $bio)

                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("전화번호*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            HStack {
                                SmallPickerButton {
                                    Text(selectedCode)
                                        .foregroundColor(.black)
                                        .font(medium18Font)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        showPhoneCodes.toggle()
                                    }
                                }
                                
                                CustomTextField(placeholder: "‘-’ 표시없이 입력해주세요.", text: $phoneNumber, font: regular18Font, keyboardType: .phonePad)
//                                    .onChange(of: phoneNumber, perform: { newValue in
//                                        if(newValue.count >= 1){
//                                            userManager.user?.business?.phoneNumber = selectedCode + newValue
//                                        } else {
//                                            userManager.user?.business?.phoneNumber = nil
//                                        }
//                                    })
//                                    .onChange(of: selectedCode, perform: { newValue in
//                                        userManager.user?.business?.phoneNumber = newValue + phoneNumber
//                                    })

                            }
                        }
                        .padding(.bottom, Size.w(30))
                        

                        Spacer().frame(height: 300)
                        
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.yellow300)
                
                
                VStack(spacing: 0) {
                    Color.yellow200
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    let pass =
                    !businessCategory.isEmpty
                    && !bio.isEmpty
                    && !phoneNumber.isEmpty
                    
                    HStack {
                        if userManager.isLoading {
                            ProgressView()
                                .tint(.black)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                        } else {
                            Button(action: {
                                if let business = userManager.user?.business {
                                    var edited = business
                                    edited.bio = self.bio
                                    edited.businessCategory = self.businessCategory
                                    edited.phoneNumber = self.selectedCode + self.phoneNumber
                                    userManager.upsertMyBusiness(business: edited) { success in
                                        print(edited)
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }) {
                                FullSizeButton(title: "저장", color: .black, bg: .yellow200, enabled: pass, loadingColor: .gray1000)
                            }
                            .disabled(!pass)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, Size.w(16))
                    .padding(.horizontal, Size.w(22))
                }
                .padding(.bottom, Size.w(36))
                .background(Color.yellow300)
                .shadow(color: Color.black.opacity(0.05), radius: 50, y: -20)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            self.phoneNumber = String(userManager.user?.business?.phoneNumber?.dropFirst(3) ?? "")
            self.businessCategory = userManager.user?.business?.businessCategory ?? ""
            self.bio = userManager.user?.business?.bio ?? ""
        }
        .onTapGesture {
            withAnimation {
                showPhoneCodes = false
                typesSheetPresented = false
            }
            closeKeyboard()
        }
        .overlay(
            typesSheetPresented ? CustomSheet {
                Picker("", selection: $businessCategory) {
                    ForEach(Constants.businessTypes, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.wheel)
//                .onAppear {
//                    withAnimation {
//                        controller.business.businessCategory = self.businessCategory
//                    }
//                }
//                .onChange(of: businessCategory) { newValue in
//                    withAnimation {
//                        controller.business.businessCategory = self.businessCategory
//                    }
//                }
            } : nil
        )
        .overlay(
            showPhoneCodes ? CustomSheet {
                Picker("", selection: $selectedCode) {
                    ForEach(Constants.phoneCodeList, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.wheel)
            } : nil
        )
    }
}

#Preview {
    BusinessSettingsInfo()
}
