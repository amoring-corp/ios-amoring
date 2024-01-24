//
//  BusinessSignUpTerms.swift
//  amoring
//
//  Created by 이준녕 on 1/12/24.
//

import SwiftUI

struct BusinessSignUpTerms: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var controller: BusinessSignUpController
    
    @State var termsSelected = false
    @State var privacySelected = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("환영합니다!")
                .font(bold32Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(56))
                .padding(.bottom, Size.w(16))
            
            Text("회원님의 성공적인 비즈니스를 돕기위해\n아래의 이용약관에 동의해주세요.")
                .font(regular16Font)
                .foregroundColor(.black)
                .lineSpacing(6)
                .padding(.horizontal, Size.w(14))
                .padding(.bottom, Size.w(40))
           
            
            HStack {
                Image(systemName: termsSelected && privacySelected ? "checkmark.circle.fill" : "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(32), height: Size.w(32))
                    .foregroundStyle(termsSelected && privacySelected ? .yellow300 : .yellow900.opacity(0.3), .yellow900)
                Text("전체동의")
                    .font(medium16Font)
                    .foregroundColor(termsSelected && privacySelected ? .gray100 : .gray900)
                Spacer()
            }
            .padding(.vertical, Size.w(13))
            .padding(.horizontal, Size.w(10))
            .background(Color.yellow800.opacity(termsSelected && privacySelected ? 1 : 0.01))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(termsSelected && privacySelected ? Color.clear : Color.yellow600)
            )
            .onTapGesture(perform: selectAll)
            .padding(.bottom, Size.w(22))
            
            HStack(spacing: Size.w(13)) {
                Image(systemName: termsSelected ? "checkmark.square" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(20), height: Size.w(20))
                
                Text("이용약관 동의 (필수)")
                    .font(regular16Font)
                    .foregroundColor(.yellow800)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(12), height: Size.w(12))
            }
            .foregroundColor(.yellow600)
            .padding(.horizontal, Size.w(10))
            .padding(.vertical, Size.w(13))
            .background(Color.yellow300)
            .onTapGesture {
                withAnimation {
                    self.termsSelected.toggle()
                }
            }
            
            HStack(spacing: Size.w(13)) {
                Image(systemName: privacySelected ? "checkmark.square" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(20), height: Size.w(20))
                
                Text("개인정보 필수 동의서 (필수)")
                    .font(regular16Font)
                    .foregroundColor(.yellow800)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(12), height: Size.w(12))
            }
            .foregroundColor(.yellow600)
            .padding(.horizontal, Size.w(10))
            .padding(.vertical, Size.w(13))
            .background(Color.yellow300)
            .onTapGesture {
                withAnimation {
                    self.privacySelected.toggle()
                }
            }
            
            Spacer()

            HStack {
                NavigationLink(destination: {
                    BusinessSignUpPrepare()
                }) {
                    BlackButton(title: "다음", enabled: termsSelected && privacySelected)
                }
                .disabled(!termsSelected || !privacySelected)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, Size.w(36))
        }
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .navigationBarBackButtonHidden()
        .onTapGesture(perform: closeKeyboard)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(leading:
            BackButton(action: { presentationMode.wrappedValue.dismiss() })
        )
    }
    
    private func selectAll() {
        withAnimation {
            if !termsSelected || !privacySelected {
                self.termsSelected = true
                self.privacySelected = true
            } else {
                self.termsSelected = false
                self.privacySelected = false
            }
        }
    }
}

#Preview {
    BusinessSignUpTerms()
}
