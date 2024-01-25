//
//  CustomTextField.swift
//  amoring
//
//  Created by 이준녕 on 12/4/23.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String? = nil
    @Binding var text: String
    var font: Font = semiBold22Font
    var placeholderFont: Font = regular20Font
    var keyboardType: UIKeyboardType = .default
  
    var body: some View {
        TextField("", text: $text)
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .keyboardType(keyboardType)
            .placeholder(when: text.isEmpty) {
                Text(placeholder ?? "")
                    .font(placeholderFont)
                    .foregroundColor(.gray200)
            }
            .font(font)
            .foregroundColor(.black)
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(20))
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
    }
}

struct MultilineCustomTextField: View {
    var placeholder: String? = nil
    @Binding var text: String
    var font: Font = semiBold18Font
    var linelimit: Int = 3
    
    var body: some View {
        if #available(iOS 16.0, *) {
            TextField("", text: $text, axis: .vertical)
                .autocorrectionDisabled()
                .lineLimit(linelimit)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder ?? "")
                        .font(regular20Font)
                        .foregroundColor(.gray200)
                }
                .font(font)
                .foregroundColor(.black)
                .padding(.vertical, Size.w(16))
                .padding(.horizontal, Size.w(20))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                .layoutPriority(2)
        } else {
            CustomTextField(placeholder: placeholder, text: $text, font: font)
        }
    }
}

struct CustomSecureField: View {
    var placeholder: String? = nil
    @Binding var text: String
    @State var show: Bool = false
    var font: Font = semiBold22Font
    var placeholderFont: Font = regular20Font
    var onSubmit: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            SecureField("", text: $text)
                .opacity(show ? 0 : 1)
                .onSubmit {
                    if let onSubmit {
                        onSubmit()
                    }
                }
                .placeholder(when: text.isEmpty) {
                    Text(placeholder ?? "")
                        .font(placeholderFont)
                        .foregroundColor(.gray200)
                }
                .placeholder(when: show) {
                    TextField("", text: $text)
                        .font(font)
                        .foregroundColor(.black)
                }
                .font(font)
                .foregroundColor(.black)
                
            Spacer()
            
            Button(action: {
                show.toggle()
            }) {
                Text(show ? "숨기기" : "보기")
                    .font(bold16Font)
                    .foregroundColor(.yellow600)
            }
        }
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(20))
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
    }
}

struct DisabledMenuLine: View {
    let title: String
    var text: String?
  
    var body: some View {
        VStack(alignment: .leading, spacing: Size.w(10)) {
            Text(title)
                .font(regular16Font)
                .foregroundColor(.black)
                .padding(.horizontal, Size.w(14))
                .padding(.top, Size.w(30))
            
            Text(text ?? "")
                .font(medium18Font)
                .foregroundColor(.gray800)
                .padding(.vertical, Size.w(16))
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.yellow200))
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    VStack {
        CustomTextField(placeholder: "asef", text: .constant("jay@jay.com"))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
}
