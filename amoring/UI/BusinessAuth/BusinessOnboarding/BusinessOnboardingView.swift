//
//  BusinessOnboardingView.swift
//  amoring
//
//  Created by 이준녕 on 1/10/24.
//

import SwiftUI

struct BusinessOnboardingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager
    @StateObject var controller: BusinessOnboardingController = BusinessOnboardingController()
    
    @State var name: String = ""
    @State var representativeName: String = ""
    @State var businessType: String = ""
    @State var businessIndustry: String = ""
    @State var address: String = ""
    @State var registrationNumber: String = ""
    
    @State var next: Bool = false
    @State var presentImporter: Bool = false
    @State var fileAtached: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    CustomNavigationViewLogout(offset: $contentOffset, title: "매장인증", action: sessionManager.signOut)
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
                                
                                CustomTextField(placeholder: "매장명을 입력해주세요.", text: $name, font: regular18Font, placeholderFont: regular18Font)
                                    .onChange(of: name, perform: { newValue in
                                        //                                    if(newValue.count >= 20){
                                        //                                        name = String(newValue.prefix(20))
                                        //                                    }
                                        if(newValue.count >= 1){
                                            controller.business.businessName = newValue
                                        } else {
                                            controller.business.businessName = nil
                                        }
                                    })
                            }
                            .padding(.bottom, Size.w(30))
                            
                            VStack(alignment: .leading) {
                                Text("대표자명*")
                                    .font(regular16Font)
                                    .foregroundColor(.black)
                                    .padding(.leading, Size.w(14))
                                
                                CustomTextField(placeholder: "대표자명을 입력해주세요.", text: $representativeName, font: regular18Font)
                                    .onChange(of: representativeName, perform: { newValue in
                                        if(newValue.count >= 1){
                                            controller.business.representativeName = newValue
                                        } else {
                                            controller.business.representativeName = nil
                                        }
                                    })
                            }
                            .padding(.bottom, Size.w(30))
                            
                            VStack(alignment: .leading) {
                                Text("업태*")
                                    .font(regular16Font)
                                    .foregroundColor(.black)
                                    .padding(.leading, Size.w(14))
                                
                                CustomTextField(placeholder: "사업자등록증의 업태를 입력하세요.", text: $businessType, font: regular18Font)
                                    .onChange(of: businessType, perform: { newValue in
                                        if(newValue.count >= 1){
                                            controller.business.businessType = newValue
                                        } else {
                                            controller.business.businessType = nil
                                        }
                                    })
                            }
                            .padding(.bottom, Size.w(30))
                            
                            VStack(alignment: .leading) {
                                Text("종목*")
                                    .font(regular16Font)
                                    .foregroundColor(.black)
                                    .padding(.leading, Size.w(14))
                                
                                CustomTextField(placeholder: "사업자등록증의 종목을 입력하세요.", text: $businessIndustry, font: regular18Font)
                                    .onChange(of: businessIndustry, perform: { newValue in
                                        if(newValue.count >= 1){
                                            controller.business.businessIndustry = newValue
                                        } else {
                                            controller.business.businessIndustry = nil
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
                                    .onChange(of: address, perform: { newValue in
                                        if (newValue.count >= 1) {
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
                                
                                CustomTextField(placeholder: "000 - 00 - 00000", text: $registrationNumber, font: regular18Font, keyboardType: .decimalPad)
                                    .onChange(of: registrationNumber, perform: { newValue in
                                        if(newValue.count >= 1){
                                            controller.business.registrationNumber = newValue
                                        } else {
                                            controller.business.registrationNumber = nil
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
                                Button(action: {
                                    presentImporter = true
                                }) {
                                    ZStack {
                                        if fileAtached {
                                            HStack {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: Size.w(32), height: Size.w(32))
                                                    .foregroundStyle(.green200, .green900)
                                                Text("완료")
                                                    .font(medium16Font)
                                                    .foregroundColor(.green300)
                                                Spacer()
                                                Text("다시 첨부하기")
                                                    .font(medium16Font)
                                                    .foregroundColor(.gray100)
                                                Image("ic-refresh")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: Size.w(17), height: Size.w(17))
                                                    .foregroundColor(.gray100)
                                                    .padding(.trailing, Size.w(10))
                                                
                                            }
                                        } else {
                                            HStack {
                                                Image(systemName: "paperclip.circle.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: Size.w(32), height: Size.w(32))
                                                    .foregroundStyle(.yellow300, .yellow900)
                                                Spacer()
                                            }
                                            HStack {
                                                Spacer()
                                                Text("파일 첨부하기")
                                                    .font(medium16Font)
                                                    .foregroundColor(.gray100)
                                                Spacer()
                                            }
                                        }
                                    }
                                    .padding(.vertical, Size.w(13))
                                    .padding(.horizontal, Size.w(10))
                                    .background(fileAtached ? Color.green800 : Color.yellow800)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf, .jpeg, .png]) { result in
                                    switch result {
                                    case .success(let url):
                                        print(url.absoluteString)
                                        //                                    url.startAccessingSecurityScopedResource()
                                        fileAtached = true
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                                .onChange(of: presentImporter) { bool in
                                    // TODO: need tests
                                    UITabBar.appearance().isHidden = !bool
                                }
                            }
                            .padding(.bottom, Size.w(22))
                            
                            Text("첨부가능 파일 형식은 Png, Jpg, PDF 입니다.\n파일은 1개만 첨부가 가능하며, 파일 첨부 후 파일을 다시 첨부시 마지막으로 첨부된 파일이 최종 등록됩니다.")
                                .font(light14Font)
                                .foregroundColor(.gray900)
                                .lineLimit(5)
                                .padding(.horizontal, Size.w(14))
                            
                            Spacer().frame(height: 300)
                            
                            NavigationLink(isActive: $next, destination: {
                                BusinessOnboardingStep2()
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
                        
                        let pass = 
                        !((controller.business.businessName?.isEmpty) == nil)
                        && !((controller.business.representativeName?.isEmpty) == nil)
                        && !((controller.business.businessType?.isEmpty) == nil)
                        && !((controller.business.businessIndustry?.isEmpty) == nil)
                        && !((controller.business.address?.isEmpty) == nil)
                        && !((controller.business.registrationNumber?.isEmpty) == nil)
                        
                        Button(action: {
                            if pass {
                                userManager.upsertMyBusiness(business: controller.business) { success in
                                    next = success
                                }
//                                next = true
                            }
                        }) {
                            BlackButton(title: "다음", enabled: pass)
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
        }
        .navigationBarHidden(true)
        .onTapGesture {
            closeKeyboard()
        }
        .environmentObject(controller)
    }
}

#Preview {
    BusinessOnboardingView()
}
