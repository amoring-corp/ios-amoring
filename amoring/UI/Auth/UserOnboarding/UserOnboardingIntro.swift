//
//  UserOnboardingIntro.swift
//  amoring
//
//  Created by 이준녕 on 1/3/24.
//

import SwiftUI

struct UserOnboardingIntro: View {
    @EnvironmentObject var controller: UserOnboardingController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
//        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    CustomNavigationView(offset: $contentOffset, title: "소개하기", back: { self.presentationMode.wrappedValue.dismiss() })
                    TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("회원님을 소개하세요")
                                .font(bold32Font)
                                .foregroundColor(.black)
                                .padding(.horizontal, Size.w(14))
                                .padding(.top, Size.w(56))
                                .padding(.bottom, Size.w(10))
                            
                            Text("인연은 신뢰속에서 시작됩니다.\n회원님의 ***키와** 몸무게 등 기본정보를 알려주세요.")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.horizontal, Size.w(14))
                                .padding(.bottom, Size.w(40))
                            
                            VStack(alignment: .leading) {
                                Text("직업")
                                    .font(regular16Font)
                                    .foregroundColor(.black)
                                    .padding(.leading, Size.w(14))
                                
                                CustomTextField(placeholder: "예: 대학생, 직장인...", text: $occupation, font: regular18Font)
                                    .onChange(of: occupation, perform: { newValue in
                                        if(newValue.count >= 20){
                                            occupation = String(newValue.prefix(20))
                                        }
                                        if(newValue.count >= 1){
                                            controller.userProfile.occupation = newValue
                                        } else {
                                            controller.userProfile.occupation = nil
                                        }
                                    })
                            }
                            .padding(.bottom, Size.w(30))
                            
                            PickerButton(title: "키") {
                                if let height = controller.userProfile.height {
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
                            
                            PickerButton(title: "몸무게") {
                                if let weight = controller.userProfile.weight {
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
                            
                            
                            PickerButton(title: "MBTI") {
                                if let mbti = controller.userProfile.mbti {
                                    Text(mbti)
                                }
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
                                    .foregroundColor(.black)
                                    .padding(.leading, Size.w(14))
                                
                                CustomTextField(placeholder: "예: 고졸, 학사, 석사, 박사...", text: $education, font: regular18Font)
                                    .onChange(of: education, perform: { newValue in
                                        if(newValue.count >= 20){
                                            education = String(newValue.prefix(20))
                                        }
                                        if(newValue.count >= 1){
                                            controller.userProfile.education = newValue
                                        } else {
                                            controller.userProfile.education = nil
                                        }
                                    })
                            }
                            .padding(.bottom, Size.w(30))
                            
                            Spacer().frame(height: 300)
                            
                            NavigationLink(isActive: $next, destination: {
                                UserOnboardingInterests()
                            }) {
                                EmptyView()
                            }
                        }
                        .padding(.horizontal, Size.w(22))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Color.yellow300)
                    
                    
                    VStack(spacing: 0) {
                        Color.yellow200
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                        
                        TagCloudView(tags: [
                            controller.userProfile.occupation,
                            controller.userProfile.height.toHeight(),
                            controller.userProfile.weight.toWeight(),
                            controller.userProfile.mbti,
                            controller.userProfile.education
                        ], totalHeight: CGFloat.infinity, isDark: true)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, Size.w(32))
                        .padding(.top, Size.w(25))
                        
                        let pass = !controller.userProfile.height.isNil && !controller.userProfile.weight.isNil
                        
                        Button(action: {
                            if pass {
                                next = true
                            }
                        }) {
                            NextBlackButton(enabled: pass)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, Size.w(16))
                        .padding(.horizontal, Size.w(22))
                    }
                    .padding(.bottom, Size.w(36))
                    .background(Color.yellow300)
                    .shadow(color: Color.black.opacity(0.1), radius: 50, y: -20)
                }
            }
            .navigationBarHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
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
                            .onChange(of: mbti) { newValue in
                                withAnimation {
                                    controller.userProfile.mbti = newValue.rawValue
                                }
                            }
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
                            .onAppear {
                                controller.userProfile.weight = self.weight
                            }
                            .onChange(of: weight) { newValue in
                                withAnimation {
                                    controller.userProfile.weight = newValue
                                }
                            }
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
                            .onAppear {
                                controller.userProfile.height = self.height
                            }
                            .onChange(of: height) { newValue in
                                withAnimation {
                                    controller.userProfile.height = newValue
                                }
                            }
                        }
                    }
                }
            )
//        }
    }
}

#Preview {
    UserOnboardingIntro().environmentObject(UserOnboardingController())
}
