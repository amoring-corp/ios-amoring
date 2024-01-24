//
//  UserOnboardingInterests.swift
//  amoring
//
//  Created by 이준녕 on 1/3/24.
//

import SwiftUI

struct UserOnboardingInterests: View {
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedInterests: [(String, String)] = []
    
    @State var next: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "관심사", back: { self.presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("회원님을 소개하세요")
                            .font(bold32Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(56))
                            .padding(.bottom, Size.w(10))
                        
                        Text("인연은 신뢰속에서 시작됩니다.\n회원님을 소개하고 인연을 만들어보세요.")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(40))
                        
                        ForEach(userManager.interestCategories, id: \.self) { cat in
                            TagCloudViewSelectable(cat: cat, selectedInterests: $selectedInterests)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, Size.w(30))
                        }
                        
                        Spacer().frame(height: 300)
                        
                        NavigationLink(isActive: $next, destination: {
                            UserOnboardingBio()
                        }) {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.yellow300)
            }
            
            VStack(spacing: 0) {
                Color.yellow200
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                
                TagCloudViewSelected(selectedInterests: $selectedInterests, totalHeight: CGFloat.infinity)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Size.w(32))
                    .padding(.top, Size.w(25))
                
                Button(action: {
                    userManager.connectInterests(ids: selectedInterests.map{ $0.0 }) { success in
                        next = success
                    }
                }) {
                    BlackButton(title: "다음")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, Size.w(16))
                .padding(.horizontal, Size.w(22))
            }
            .padding(.bottom, Size.w(36))
            .background(Color.yellow300)
            .shadow(color: Color.black.opacity(0.1), radius: 50, y: -20)
        }
        .navigationBarHidden(true)
        .onAppear {
            userManager.getInterests()
        }
        //        .navigationBarItems(leading:
        //                                Button(action: {
        //            self.presentationMode.wrappedValue.dismiss()
        //        }) {
        //            Image(systemName: "chevron.left")
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: Size.w(20), height: Size.w(20))
        //                .foregroundColor(.black)
        //        }
        //        )
    }
}

#Preview {
    UserOnboardingInterests().environmentObject(UserOnboardingController())
}
