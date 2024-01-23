//
//  PickerButton.swift
//  amoring
//
//  Created by 이준녕 on 1/3/24.
//

import SwiftUI

struct PickerButton<Content: View>: View {
    var title: String? = nil
    var titleColor: Color = Color.black
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(regular16Font)
                    .foregroundColor(titleColor)
                    .padding(.leading, Size.w(14))
            }
            HStack {
                ZStack {
                    Text("선택하기")
                        .foregroundColor(.gray400)
                    content()
                        .font(medium18Font)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                }
                
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.yellow350)
                    .font(regular20Font)
            }
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(20))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
//            .font(semiBold22Font)
            .font(medium18Font)
        }
    }
}

struct SmallPickerButton<Content: View>: View {
    var title: String? = nil
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .padding(.leading, Size.w(14))
            }
            HStack {
                content()
                    .font(medium18Font)
                    .foregroundColor(.black)
                    .background(Color.white)
                
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.yellow350)
                    .font(regular20Font)
            }
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(10))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            //            .font(semiBold22Font)
            .font(medium18Font)
            .frame(idealWidth: Size.w(86), maxWidth: Size.w(90))
        }
    }
}

struct PickerButtonDouble: View {
    var title: String? = nil
    @Binding var age: Double?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(regular16Font)
                    .foregroundColor(.black)
                    .padding(.leading, Size.w(14))
            }
            HStack {
                if let age {
                    Text(Int(age).description)
                        .foregroundColor(.black)
                } else {
                    Text("선택하기")
                        .foregroundColor(.gray400)
                }
                
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.yellow350)
                    .font(regular20Font)
            }
            .padding(.vertical, Size.w(16))
            .padding(.horizontal, Size.w(20))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
//            .font(semiBold22Font)
            .font(medium18Font)
        }
    }
}

//#Preview {
//    PickerButton()
//}
