//
//  BusinessEmail.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessEmail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    
    @State var email: String = ""
    @State var title: String = ""
    @State var text: String = ""
    @State var isReport: Bool = false
    @State var success: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                Text("무슨 일이신가요?\n아래에 남겨주시면 답변해 드리겠습니다.")
                    .font(regular16Font)
                    .foregroundColor(.yellow600)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, Size.w(36))
                    .padding(.top, Size.w(40))
                    .padding(.bottom, Size.w(40))
                
                HStack(spacing: Size.w(20)) {
                    typeButton(isReport: false)
                    typeButton(isReport: true)
                }
                .padding(.bottom, Size.w(40))
                
                CustomTextField(placeholder: "답변 받을 이메일", text: $email, keyboardType: .emailAddress)
                    .padding(.bottom, Size.w(50))
                
                CustomTextField(placeholder: "제목을 입력해주세요. (20자 이내)", text: $title)
                    .onChange(of: title, perform: { newValue in
                        if(newValue.count >= 20) {
                            title = String(newValue.prefix(20))
                        }
                    })
                    .padding(.bottom, Size.w(10))
                
                MultilineCustomTextField(placeholder: "내용을 작성해주세요.", text: $text, linelimit: 12)
                   
                EmptyView()
                    .onChange(of: text, perform: { newValue in
                        if(newValue.count >= 400) {
                            text = String(newValue.prefix(400))
                        }
                    })
                
                NavigationLink(isActive: $success, destination: {
                    BusinessEmailSuccess()
                        .onDisappear(perform: back)
                }) {
                    EmptyView()
                }
                
                Button(action: {
// TODO: Send email
                    self.sendEmail()
                }) {
                    FullSizeButton(title: "보내기", color: Color.black, bg: .yellow200, isLoading: userManager.isLoading, loadingColor: .gray1000)
                }
                .padding(.top, Size.w(100))
                
                Spacer().frame(height: 300)
                
            }
            .padding(.horizontal, Size.w(22))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .onTapGesture(perform: closeKeyboard)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("문의 / 신고하기")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: back, color: Color.black)
        )
    }
    
    @ViewBuilder
    private func typeButton(isReport: Bool) -> some View {
        let selected = isReport == self.isReport
        Text(isReport ? "신고하기" : "문의하기")
            .font(regular16Font)
            .foregroundColor(selected ? .white : .yellow600)
            .frame(maxWidth: .infinity)
            .frame(height: Size.w(35))
            .background(selected ? Color.yellow700 : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20).stroke(selected ? Color.yellow800 : Color.yellow600)
            )
            .onTapGesture {
                withAnimation {
                    self.isReport = isReport
                }
            }
    }
    
    private func sendEmail() {
        userManager.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            userManager.isLoading = false
            self.success = true
        }
    }
    
    private func back() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    BusinessEmail()
}
