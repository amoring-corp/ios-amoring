//
//  UserOnboardingName.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

struct UserOnboardingName: View {
    @EnvironmentObject var controller: UserOnboardingController
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("이름을 입력해주세요")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(10))
            
            Text("다른 사용자들에게 회원님을 소개할 수 있는\n이름을 입력해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
            
            CustomTextField(placeholder: "이름을 입력해주세요.", text: $controller.profile.name ?? "")
                .onChange(of: controller.profile.name ?? "", perform: { newValue in
                    if(newValue.count >= 15){
                        controller.profile.name = String(newValue.prefix(15))
                    }
                })
            
            Spacer()
            
            Text("회원님의 첫 인상이 되는 이름이예요!\n등록 후 변경은 불가하니 신중하게 입력하세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(30))
            
            HStack {
                NavigationLink(destination: {
                    UserOnboardingGender()
                }) {
                    BlackButton(title: "다음", enabled: !(controller.profile.name?.isEmpty ?? true))
                }
                .disabled((controller.profile.name?.isEmpty ?? true))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .onTapGesture(perform: closeKeyboard)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
            BackButton(action: sessionManager.signOut)
        )
    }
}

#Preview {
    NavigationView {
        UserOnboardingName().environmentObject(UserOnboardingController())
    }
}
