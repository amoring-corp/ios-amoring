//
//  AccountInterests.swift
//  amoring
//
//  Created by 이준녕 on 1/23/24.
//

import SwiftUI

struct AccountInterests: View {
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedInterests: [(String, String)] = []
    
    @State var next: Bool = false
    @State var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "관심사", back: { self.presentationMode.wrappedValue.dismiss() }, foregroundColor: Color.yellow300, dividerColor: Color.gray900, bg: Color.gray1000)
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("흥미있는 것들을 최대 7개까지 골라주세요. 서로의 관심사를 알면 더 쉽게 대화를 시작할 수 있어요!")
                            .font(regular16Font)
                            .foregroundColor(.gray600)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(40))
                            .padding(.bottom, Size.w(40))
                        
                        ForEach(userManager.interestCategories, id: \.self) { cat in
                            TagCloudViewSelectable(cat: cat, selectedInterests: $selectedInterests, selectedBG: Color.yellow300, selectedColor: Color.black, titleColor: Color.gray200)
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
                .background(Color.gray1000)
            }
            
            VStack(spacing: 0) {
                Color.gray900
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                
                TagCloudViewSelected(selectedInterests: $selectedInterests, totalHeight: CGFloat.infinity, isDark: true)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Size.w(32))
                    .padding(.top, Size.w(25))
                
                Button(action: {
                    userManager.reconnectInterests(ids: selectedInterests.map{ $0.0 }) { success in
                        print(success)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    YellowButton(title: "저장", enabled: true, isLoading: userManager.isLoading)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, Size.w(16))
                .padding(.horizontal, Size.w(22))
            }
            .padding(.bottom, Size.w(36))
            .background(Color.gray1000)
            .shadow(color: Color.black.opacity(0.1), radius: 50, y: -20)
        }
        .navigationBarHidden(true)
        .onAppear {
            guard let interests = userManager.user?.profile?.interests else { return }
            for interest in interests {
                self.selectedInterests.append((interest.id, interest.name))
            }
        }
    }
}

#Preview {
    AccountInterests()
}
