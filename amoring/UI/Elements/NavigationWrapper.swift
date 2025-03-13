//
//  NavigationWrapper.swift
//  amoring
//
//  Created by Sergey Li on 4/29/24.
//

import SwiftUI

struct NavigationWrapper<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: LocalizedStringKey
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(medium20Font)
                    .foregroundColor(.yellow300)
            }
        }
        .navigationBarItems(leading:
                                BackButton(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300)
        )
    }
}

    
