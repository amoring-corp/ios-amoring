//
//  BusinessEmailSuccess.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessEmailSuccess: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Image("email-success")
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(90), height: Size.w(90))
                .padding(.bottom, Size.w(16))
            
            Text("접수가 완료되었습니다.")
                .font(medium22Font)
                .foregroundColor(.gray900)
                .multilineTextAlignment(.center)
                .padding(.bottom, Size.w(16))
            
            Text("접수하신 사항에 대해 정확히 확인한 후\n빠른 답변 처리가 될 수 있도록 노력하겠습니다.\n이용해주셔서 감사합니다.")
                .font(regular16Font)
                .foregroundColor(.yellow600)
                .lineSpacing(6)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                BorderButton(title: "확인", color: .black, borderColor: .gray900)
            }
            .padding(.bottom, Size.w(36))
        }
        .navigationBarBackButtonHidden()
        .padding(.horizontal, Size.w(22))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow300)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("접수완료")
                    .font(medium20Font)
                    .foregroundColor(.black)
            }
        }
    }
}

//#Preview {
//    BusinessEmailSuccess()
//}
