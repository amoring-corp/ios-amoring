//
//  AccountIntro.swift
//  amoring
//
//  Created by 이준녕 on 1/23/24.
//

import SwiftUI

struct AccountIntro: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @StateObject var userOnboardingController: UserOnboardingController = UserOnboardingController()
    
    @State var height: Int? = nil
    @State var weight: Int? = nil
    @State var weightNotNull: Int = 60
    @State var heightNotNull: Int = 160
    @State var mbtiNotNull: mbtiE = .INTJ
    @State var occupation: String? = nil
    @State var mbti: mbtiE? = nil
    @State var education: String? = nil
    
    @State var heightPresented: Bool = false
    @State var weightPresented: Bool = false
    @State var mbtiPresented: Bool = false
    
    @State var next: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: .constant(100), title: "기본정보", back: { self.presentationMode.wrappedValue.dismiss() }, foregroundColor: Color.yellow300, dividerColor: Color.gray900, bg: Color.gray1000)
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        (
                        Text(NSLocalizedString("인연은 신뢰속에서 시작됩니다. 회원님의 ", comment: "")) +
                        Text(NSLocalizedString("*키와 몸무게", comment: "")).bold() +
                        Text(NSLocalizedString("등 기본정보를 알려주세요.", comment: ""))
                         )
                            .font(regular16Font)
                            .foregroundColor(.gray600)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(40))
                            .padding(.bottom, Size.w(40))
                        
                        VStack(alignment: .leading) {
                            Text("직업")
                                .font(regular16Font)
                                .foregroundColor(.gray200)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "예: 대학생, 회계사...", text: $occupation ?? "", font: regular18Font)
                                .onChange(of: occupation, perform: { newValue in
                                    if(newValue?.count ?? 0 >= 20){
                                        occupation = String(newValue?.prefix(20) ?? "")
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        PickerButton(title: "키*(필수)", titleColor: .gray200) {
                            if let height {
                                Text("\(Int(height).description)cm")
                            }
                        }
                        .padding(.bottom, Size.w(30))
                        .onTapGesture {
                            closeKeyboard()
                            withAnimation {
                                if !weightPresented && !mbtiPresented {
                                    heightPresented.toggle()
                                }
                                mbtiPresented = false
                                weightPresented = false
                            }
                        }
                        
                        PickerButton(title: "몸무게", titleColor: .gray200) {
                            if let weight {
                                Text("\(Int(weight).description)kg")
                            }
                        }
                        .padding(.bottom, Size.w(30))
                        .onTapGesture {
                            closeKeyboard()
                            withAnimation {
                                if !heightPresented && !mbtiPresented {
                                    weightPresented.toggle()
                                }
                                mbtiPresented = false
                                heightPresented = false
                            }
                        }
                        
                        
                        PickerButton(title: "MBTI", titleColor: .gray200) {
                            Text(self.mbti?.rawValue ?? "")
                            
                        }
                        .padding(.bottom, Size.w(30))
                        .onTapGesture {
                            closeKeyboard()
                            withAnimation {
                                if !weightPresented && !heightPresented {
                                    mbtiPresented.toggle()
                                }
                                heightPresented = false
                                weightPresented = false
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("학력")
                                .font(regular16Font)
                                .foregroundColor(.gray200)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "예: 아모링대학교", text: $education ?? "", font: regular18Font)
                                .onChange(of: education, perform: { newValue in
                                    if let newValue {
                                        if(newValue.count >= 20){
                                            education = String(newValue.prefix(20))
                                        }
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        Spacer().frame(height: 300)
                        
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.gray1000)
                
                
                VStack(spacing: 0) {
                    Color.gray900
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                    
                    DeletableTagCloudView(tags: [
                        (self.occupation, .ocu),
                        (self.height.toHeight(), .height),
                        (self.weight.toWeight(), .weight),
                        (self.mbti?.rawValue, .mbti),
                        (self.education, .edu)
                    ], totalHeight: CGFloat.infinity, isDark: false,
                                          occupation: $occupation,
                                          height: $height,
                                          weight: $weight,
                                          mbti: $mbti,
                                          education: $education
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Size.w(32))
                    .padding(.top, Size.w(25))
                    .environmentObject(userOnboardingController)
                    
//                    TagCloudView(tags: [
//                        self.occupation,
//                        self.height.toHeight(),
//                        self.weight.toWeight(),
//                        self.mbti.rawValue,
//                        self.education
//                    ], totalHeight: CGFloat.infinity, isDark: false)
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal, Size.w(32))
//                    .padding(.top, Size.w(25))
                    
                    let pass = userManager.user?.profile?.height != nil && self.height != nil
                    
                    Button(action: {
                        userManager.user?.profile?.height = self.height
                        userManager.user?.profile?.weight = self.weight
                        userManager.user?.profile?.occupation = self.occupation
                        userManager.user?.profile?.education = self.education
                        userManager.user?.profile?.mbti = self.mbti?.rawValue
                        if let profile = userManager.user?.profile {
                            userManager.updateProfile { success in
                                print("Intro Successfully saved")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        YellowButton(title: "저장", enabled: pass)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, Size.w(16))
                    .padding(.horizontal, Size.w(22))
                    .disabled(!pass)
                }
                .padding(.bottom, Size.w(36))
                .background(Color.gray1000)
                .shadow(color: Color.black.opacity(0.1), radius: 50, y: -20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarHidden(true)
        .onAppear {
            if let height = userManager.user?.profile?.height {
                self.height = height
            }
            
            if let weight = userManager.user?.profile?.weight {
                self.weight = weight
            }
            
            if let occupation = userManager.user?.profile?.occupation {
                self.occupation = occupation
            }
            
            if let education = userManager.user?.profile?.education {
                self.education = education
            }
            
            if let mbti = userManager.user?.profile?.mbti {
                if let mbtiElement = mbtiE.withLabel(mbti) {
                    self.mbti = mbtiElement
                }
            }
        }
        .onTapGesture {
            closeKeyboard()
            withAnimation {
                mbtiPresented = false
                weightPresented = false
                heightPresented = false
            }
        }
        .overlay(
            ZStack {
                if mbtiPresented {
                    CustomSheet {
                        Picker("", selection: $mbtiNotNull) {
                            ForEach(mbtiE.allCases, id: \.self) { object in
                                Text(object.rawValue).tag(object)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .onAppear {
                            self.mbtiNotNull = self.mbti == nil ? .INTJ : self.mbti ?? .INTJ
                            self.mbti = self.mbtiNotNull
                        }
                        .onChange(of: self.mbtiNotNull) { newValue in
                            withAnimation {
                                self.mbti = newValue
                            }
                        }
                    }
                } else if weightPresented {
                    CustomSheet {
                        Picker("", selection: $weightNotNull) {
                            ForEach(30..<200, id: \.self) { kg in
                                Text("\(kg)kg").tag(kg)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .onAppear {
                            self.weightNotNull = self.weight == nil ? 60 : self.weight ?? 60
                            self.weight = self.weightNotNull
                        }
                        .onChange(of: self.weightNotNull) { newValue in
                            withAnimation {
                                self.weight = newValue
                            }
                        }
                    }
                } else if heightPresented {
                    CustomSheet {
                        Picker("", selection: $heightNotNull) {
                            ForEach(100..<220, id: \.self) { cm in
                                Text("\(cm)cm").tag(cm)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .onAppear {
                            self.heightNotNull = self.height == nil ? 160 : self.height ?? 60
                            self.height = self.heightNotNull
                        }
                        .onChange(of: self.heightNotNull) { newValue in
                            withAnimation {
                                self.height = newValue
                            }
                        }
                    }
                }
            }
        )
    }
}

#Preview {
    AccountIntro()
}
