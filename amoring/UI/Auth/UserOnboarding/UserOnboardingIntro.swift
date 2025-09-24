//
//  UserOnboardingIntro.swift
//  amoring
//
//  Created by 이준녕 on 1/3/24.
//

import SwiftUI

struct UserOnboardingIntro: View {
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var height: Int = 170
        @State var age = 1998
    //    @State var occupation: String = ""
    @State var mbti: mbtiE = .ENFJ
    //    @State var education: String = ""
    
    @State var heightPresented: Bool = false
    @State var weightPresented: Bool = false
    @State var mbtiPresented: Bool = false
    
    @State var next: Bool = false
    @State var contentOffset: CGFloat = 0
    @State private var sheetPresented: Bool = false
    
    
    var body: some View {
        //        NavigationView {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "기본정보", back: { sessionManager.signOut() })
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        
                        Text("회원님을 소개하세요")
                            .font(bold32Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(56))
                            .padding(.bottom, Size.w(10))
                        
                        //                            (
                        //                            Text(NSLocalizedString("인연은 신뢰속에서 시작됩니다. 회원님의 ", comment: "")) +
                        //                            Text(NSLocalizedString("*키와 몸무게", comment: "")).bold() +
                        //                            Text(NSLocalizedString("등 기본정보를 알려주세요.", comment: ""))
                        //                             )
                        Text("intro_desc")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(40))
                        
                        VStack(alignment: .leading) {
                            Text("name_nickname")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "name_placeholder", text: $controller.profile.name ?? "")
                                .onChange(of: controller.profile.name ?? "", perform: { newValue in
                                    if(newValue.count >= 15){
                                        controller.profile.name = String(newValue.prefix(15))
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        PickerButton(title: "year_of_birth") {
                            if let age = controller.profile.birthYear {
                                Text(age.description)
                                    .foregroundColor(.black)
                                    .font(medium18Font)
                            }
                        } .onTapGesture {
                            withAnimation {
                                sheetPresented.toggle()
                            }
                        }
                        .padding(.bottom, Size.w(30))
                        
                        PickerButton(title: "height") {
                            if let height = controller.profile.height {
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
                        
                        Spacer().frame(height: 70)
                        
                        Text("등록 후 변경은 불가하니 신중하게 입력하세요.")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.trailing)
                            .lineSpacing(5)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(30))
                        
                        let pass = !controller.profile.height.isNil && !(controller.profile.name?.isEmpty ?? true) && !controller.profile.birthYear.isNil
                        
                        Button(action: {
                            if pass {
                                next = true
                            }
                        }) {
                            BlackButton(title: "다음", enabled: pass)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)

//                        .padding(.horizontal, Size.w(22))
                        
                        Spacer().frame(height: 150)
                        
                        NavigationLink(isActive: $next, destination: {
                            UserOnboardingGender()
                        }) {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.yellow300)
                
                
             
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        //            .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            closeKeyboard()
            withAnimation {
                sheetPresented = false
                
                heightPresented = false
            }
        }
        .overlay(
            ZStack {
                if sheetPresented {
                    CustomSheet {
                        let endYear = (Int(Calendar.current.component(.year, from: Date()).description) ?? 2025) - 18
                        let startYear = (Int(Calendar.current.component(.year, from: Date()).description) ?? 2025) - 50
                        Picker("", selection: $age) {
                            ForEach(startYear..<endYear, id: \.self) { year in
                                Text(String(year)).tag(year)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .onAppear {
                            if let birthYear = controller.profile.birthYear {
                                withAnimation {
                                    controller.profile.birthYear = self.age
                                }
                            }
                        }
                        .onChange(of: age) { newAge in
                            withAnimation {
                                controller.profile.birthYear = newAge
                            }
                        }
                    }
                } else if heightPresented {
                    CustomSheet {
                        Picker("", selection: $height) {
                            ForEach(140..<220, id: \.self) { cm in
                                Text("\(cm)cm").tag(cm)
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .onAppear {
                            controller.profile.height = self.height
                        }
                        .onChange(of: height) { newValue in
                            withAnimation {
                                controller.profile.height = newValue
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
