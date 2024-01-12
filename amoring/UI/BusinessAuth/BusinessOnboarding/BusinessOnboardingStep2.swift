//
//  BusinessOnboardingStep2.swift
//  amoring
//
//  Created by 이준녕 on 1/12/24.
//

import SwiftUI

struct BusinessOnboardingStep2: View {
    @EnvironmentObject var controller: BusinessOnboardingController
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name: String = ""
    @State var representative: String = ""
    @State var type: String = ""
    @State var category: String = ""
    @State var address: String = ""
    @State var number: String = ""
    
    @State var next: Bool = false
    @State var presentImporter: Bool = false
    @State var typesSheetPresented: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "매장정보", back: { presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("매장을 홍보하세요")
                            .font(bold32Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(56))
                            .padding(.bottom, Size.w(10))
                        
                        Text("아래의 내용은 ***전부 필수**로 입력하셔야 합니다.\n고객에게 노출되는 정보이니 정확히 작성해주세요.\n나중에 매장정보에서 수정도 가능합니다.")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(40))
                        
                        VStack(alignment: .leading) {
                            Text("매장명*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            PickerButton {
                                if let type = controller.business.type {
                                    Text(type)
                                        .foregroundColor(.black)
                                        .font(medium18Font)
                                }
                            } 
                            .onTapGesture {
                                withAnimation {
                                    typesSheetPresented.toggle()
                                }
                            }
                        }
                        .padding(.bottom, Size.w(30))

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
            withAnimation {
                typesSheetPresented.toggle()
            }
            closeKeyboard()
        }
        .overlay(
            typesSheetPresented ? CustomSheet {
                Picker("", selection: $type) {
                    ForEach(Constants.businessTypes, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.wheel)
                .onAppear {
                    withAnimation {
                        controller.business.type = self.type
                    }
                }
                .onChange(of: type) { newAge in
                    withAnimation {
                        controller.business.type = self.type
                    }
                }
            } : nil
        )
    }
}

#Preview {
    BusinessOnboardingStep2()
}
