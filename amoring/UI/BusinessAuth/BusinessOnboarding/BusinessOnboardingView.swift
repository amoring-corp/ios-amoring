//
//  BusinessOnboardingView.swift
//  amoring
//
//  Created by 이준녕 on 1/10/24.
//

import SwiftUI

struct BusinessOnboardingView: View {
    @EnvironmentObject var controller: BusinessOnboardingController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name: String = ""
    @State var representative: String = ""
    @State var type: String = ""
    @State var category: String = ""
    @State var address: String = ""
    @State var number: String = ""
    
    @State var next: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "소개하기", back: { self.presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("매장을 인증하세요")
                            .font(bold32Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(56))
                            .padding(.bottom, Size.w(10))
                        
                        Text("아래의 내용은 ***전부 필수**로 입력하셔야 합니다.\n사업자등록증  및 작성된 정보가 매장 정보와 불일치 또는 허위 정보일 시 서비스 이용이 중지됩니다.")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(40))
                        
                        VStack(alignment: .leading) {
                            Text("매장명*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "매장명을 입력해주세요.", text: $name, font: regular18Font)
                                .onChange(of: name, perform: { newValue in
//                                    if(newValue.count >= 20){
//                                        name = String(newValue.prefix(20))
//                                    }
                                    if(newValue.count >= 1){
                                        controller.business.name = newValue
                                    } else {
                                        controller.business.name = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                      
                        VStack(alignment: .leading) {
                            Text("대표자명*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "대표자명을 입력해주세요.", text: $representative, font: regular18Font)
                                .onChange(of: name, perform: { newValue in
                                    if(newValue.count >= 1){
                                        controller.business.representative = newValue
                                    } else {
                                        controller.business.representative = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("업태*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "사업자등록증의 업태를 입력하세요.", text: $category, font: regular18Font)
                                .onChange(of: name, perform: { newValue in
                                    if(newValue.count >= 1){
                                        controller.business.category = newValue
                                    } else {
                                        controller.business.category = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("종목*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "사업자등록증의 종목을 입력하세요.", text: $type, font: regular18Font)
                                .onChange(of: name, perform: { newValue in
                                    if(newValue.count >= 1){
                                        controller.business.type = newValue
                                    } else {
                                        controller.business.type = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("주소*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "매장 주소를 입력해주세요.", text: $address, font: regular18Font)
                                .onChange(of: name, perform: { newValue in
                                    if(newValue.count >= 1){
                                        controller.business.address = newValue
                                    } else {
                                        controller.business.address = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("사업자등록번호*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            CustomTextField(placeholder: "000 - 00 - 00000", text: $number, font: regular18Font)
                                .onChange(of: name, perform: { newValue in
                                    if(newValue.count >= 1){
                                        controller.business.number = newValue
                                    } else {
                                        controller.business.number = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("사업자등록증 첨부*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            //FIXME: implement it
                            Button(action: {}) {
                                HStack {
                                    Image("pin")
                                    Text("파일 첨부하기")
                                }
                            }
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
                    
                    // FIXME: Implement passing condition
//                    let pass = !controller.user.height.isNil && !controller.user.weight.isNil
                    let pass = true
                    
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
        .onTapGesture {
            closeKeyboard()
        }
    }
}

#Preview {
    BusinessOnboardingView()
}
