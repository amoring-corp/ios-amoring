//
//  BusinessEnterView.swift
//  amoring
//
//  Created by 이준녕 on 11/23/23.
//

import SwiftUI

struct BusinessEnterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var sessionManager: SessionManager
    @Binding var isLocked: Bool
    @State var password = ""
    @State var warning = false
    
    var body: some View {
        let user = userManager.user
        let business = user?.business
        VStack(alignment: .center, spacing: 0) {
            Text("접근 권한 확인을 위해서\n비밀번호를 다시 한번 입력해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(40))
            
            CustomSecureField(placeholder: "비밀번호를 입력해주세요.", text: $password, onSubmit: {
                // TODO: put check here
                withAnimation {
                    isLocked = false
                }
            })
            
            Spacer()
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .onTapGesture(perform: closeKeyboard)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("AMORING")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: { presentationMode.wrappedValue.dismiss() })
        )
    }
}

#Preview {
    BusinessEnterView(isLocked: .constant(false))
}
