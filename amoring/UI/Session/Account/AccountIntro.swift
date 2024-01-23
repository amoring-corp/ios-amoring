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
    
    @State var height: Int = 160
    @State var weight: Int = 60
    @State var occupation: String = ""
    @State var mbti: mbtiE = .ENFJ
    @State var education: String = ""
    
    @State var heightPresented: Bool = false
    @State var weightPresented: Bool = false
    @State var mbtiPresented: Bool = false
    
    @State var next: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "기본정보", back: { self.presentationMode.wrappedValue.dismiss() }, foregroundColor: Color.yellow300, dividerColor: Color.gray900, bg: Color.gray1000)
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("인연은 신뢰속에서 시작됩니다.\n회원님의 ***키와 몸무게** 등 기본정보를 알려주세요.")
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
                            
                            CustomTextField(placeholder: "예: 대학생, 직장인...", text: $occupation, font: regular18Font)
                                .onChange(of: occupation, perform: { newValue in
                                    if(newValue.count >= 20){
                                        occupation = String(newValue.prefix(20))
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        PickerButton(title: "키*", titleColor: .gray200) {
                            Text("\(Int(height).description)cm")
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
                        
                        PickerButton(title: "몸무게*", titleColor: .gray200) {
                                Text("\(Int(weight).description)kg")
                            
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
                            Text(self.mbti.rawValue)
                            
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
                            Text("교육")
                                .font(regular16Font)
                                .foregroundColor(.gray200)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "예: 고졸, 학사, 석사, 박사...", text: $education, font: regular18Font)
                                .onChange(of: education, perform: { newValue in
                                    if(newValue.count >= 20){
                                        education = String(newValue.prefix(20))
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
                    
                    TagCloudView(tags: [
                        self.occupation,
                        self.height.toHeight(),
                        self.weight.toWeight(),
                        self.mbti.rawValue,
                        self.education
                    ], totalHeight: CGFloat.infinity, isDark: false)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Size.w(32))
                    .padding(.top, Size.w(25))
                    
//                    let pass = !controller.userProfile.height.isNil && !controller.userProfile.weight.isNil
                    let pass = true
                    
                    Button(action: {
                        userManager.user?.userProfile?.height = self.height
                        userManager.user?.userProfile?.weight = self.weight
                        userManager.user?.userProfile?.occupation = self.occupation
                        userManager.user?.userProfile?.education = self.education
                        userManager.user?.userProfile?.mbti = self.mbti.rawValue
                        if let userProfile = userManager.user?.userProfile {
                            userManager.updateUserProfile(userProfile: userProfile) { success in
                                print("Intro Successfully saved")
                            }
                        }
                    }) {
                        YellowSaveButton(enabled: pass)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, Size.w(16))
                    .padding(.horizontal, Size.w(22))
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
            if let height = userManager.user?.userProfile?.height {
                self.height = height
            }
            
            if let weight = userManager.user?.userProfile?.weight {
                self.weight = weight
            }
            
            if let occupation = userManager.user?.userProfile?.occupation {
                self.occupation = occupation
            }
            
            if let education = userManager.user?.userProfile?.education {
                self.education = education
            }
            
            if let mbti = userManager.user?.userProfile?.mbti {
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
                        Picker("", selection: $mbti) {
                            ForEach(mbtiE.allCases, id: \.self) { object in
                                Text(object.rawValue).tag(object)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                } else if weightPresented {
                    CustomSheet {
                        Picker("", selection: $weight) {
                            ForEach(30..<200, id: \.self) { kg in
                                Text("\(kg)kg").tag(kg)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                } else if heightPresented {
                    CustomSheet {
                        Picker("", selection: $height) {
                            ForEach(100..<220, id: \.self) { cm in
                                Text("\(cm)cm").tag(cm)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
            }
        )
    }
}

#Preview {
    AccountIntro()
}
