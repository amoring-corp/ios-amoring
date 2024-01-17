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
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var businessName: String = ""
    @State var representativeTitle: String = ""
    @State var businessType: String = ""
    @State var businessCategory: String = "클럽"
    @State var address: String = ""
    @State var registrationNumber: String = ""
    @State var phoneNumber: String = ""
    
    @State var next: Bool = false
    @State var presentImporter: Bool = false
    @State var typesSheetPresented: Bool = false
    @State var contentOffset: CGFloat = 0
    
    @State private var pictures: [PictureModel] = []
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showPermissionDenied: Bool = false
    @State private var editIndex: Int? = nil
    
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
                        
//                        VStack(alignment: .leading) {
//                            Text("매장명*")
//                                .font(regular16Font)
//                                .foregroundColor(.black)
//                                .padding(.leading, Size.w(14))
                            
                            PickerButton(title: "매장명*") {
                                if let businessCategory = controller.business.businessCategory {
                                    Text(businessCategory)
                                        .foregroundColor(.black)
                                        .font(medium18Font)
                                }
                            } 
                            .onTapGesture {
                                withAnimation {
                                    typesSheetPresented.toggle()
                                }
                            }
//                        }
                        .padding(.bottom, Size.w(30))

                        VStack(alignment: .leading) {
                            Text("매장소개*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                                .onChange(of: controller.business.bio ?? "", perform: { newValue in
                                    if(newValue.count >= 150){
                                        controller.business.bio = String(newValue.prefix(150))
                                    }
                                })
                            if #available(iOS 16.0, *) {
                                MultilineCustomTextField(placeholder: "고객들이 회원님의 매장을 잘 이해할 수 있도록 간단한 소개 부탁드립니다. 소개는 150자 이하로 부탁드립니다.", text: $controller.business.bio ?? "")
                                    .layoutPriority(2)
                            } else {
                                CustomTextField(placeholder: "고객들이 회원님의 매장을 잘 이해할 수 있도록 간단한 소개 부탁드립니다. 소개는 150자 이하로 부탁드립니다.", text: $controller.business.bio ?? "", font: semiBold18Font)
                            }
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("전화번호*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            // TODO: Change to two parts version with City Code dropdown
                            CustomTextField(placeholder: "‘-’ 표시없이 입력해주세요.", text: $phoneNumber, font: regular18Font)
                                .onChange(of: phoneNumber, perform: { newValue in
                                    if(newValue.count >= 1){
                                        controller.business.phoneNumber = newValue
                                    } else {
                                        controller.business.phoneNumber = nil
                                    }
                                })
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("사진* (최소 3개이상)")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                           
                            PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                                confirmRemoveImageIndex = index
                                showRemoveConfirmation.toggle()
                            }, onAddImageClick: {
                                showContentTypeSheet.toggle()
                            })
//                            .padding(.horizontal, Size.w(14))
                        }
                        .padding(.bottom, Size.w(30))
                        .sheet(isPresented: $showContentTypeSheet) {
                            ImagePicker(pictures: $pictures, photoIndex: editIndex).ignoresSafeArea()
                                .onDisappear {
                                    self.editIndex = nil
                                }
                        }
                        .actionSheet(isPresented: $showRemoveConfirmation) {
                            if confirmRemoveImageIndex >= 3 {
                                ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                                    .default(Text("등록"), action: {
                                        self.editIndex = confirmRemoveImageIndex
                                        showContentTypeSheet.toggle()
                                    }),
                                    .destructive(Text("삭제"), action: removePicture),
                                    .cancel()
                                ])
                            } else {
                                ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                                    .default(Text("등록"), action: {
                                        self.editIndex = confirmRemoveImageIndex
                                        showContentTypeSheet.toggle()
                                    }),
                                    .cancel()
                                ])
                            }
                        }
                        
                        
                        Spacer().frame(height: 300)
                        
                        NavigationLink(isActive: $next, destination: {
                            BusinessOnboardingSuccess()
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

                    let pass = true
                    
                    HStack {
                        if userManager.isLoading {
                            ProgressView()
                                .tint(.black)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                        } else {
                            Button(action: {
                                let images = pictures.map({ $0.picture })
                                userManager.uploadBusinessImages(images: images) { success in
                                    if success {
                                        userManager.upsertMyBusiness(business: controller.business) { success in
                                            print(controller.business)
                                            self.next = success
                                        }
                                    }
                                }
//                                next = true
                            }) {
                                FullSizeButton(title: "가입하기")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
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
                .onAppear {
                    withAnimation {
                        controller.business.businessCategory = self.businessCategory
                    }
                }
                .onChange(of: businessCategory) { newValue in
                    withAnimation {
                        controller.business.businessCategory = self.businessCategory
                    }
                }
            } : nil
        )
    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
}

#Preview {
    BusinessOnboardingStep2()
}
