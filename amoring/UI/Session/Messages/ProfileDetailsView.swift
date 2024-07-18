//
//  ProfileDetailsView.swift
//  amoring
//
//  Created by 이준녕 on 6/24/24.
//

import SwiftUI
import AmoringAPI

struct ProfileDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let profile: ProfileInfo
    
    @State private var fitInScreen = false
    @State private var scrollOffset: CGFloat = 0
    @State var heightPadding: CGFloat = Size.w(131)
    
    private let screenWidthLimit = UIScreen.main.bounds.width * 0.5
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                //                ScrollView(showsIndicators: false) {
                
                TrackableScrollView(showIndicators: false, contentOffset: $scrollOffset) {
                    VStack(spacing: 0) {
                        ProfileCardView(profile: profile,
                                        width: reader.size.width - Size.w(20),
                                        height: reader.size.height - heightPadding
                        )
                        
                        ExpandedView(profile: profile)
                    }
                    .background(Color.yellow350)
                    .frame(
                        maxWidth: reader.size.width - Size.w(20),
                        /// bottom bar + 56paddiing + 44navbar + saveAreaBottom
                        maxHeight: .infinity, alignment: .top)
                    .cornerRadius(24)
                    /// bottom bar + 56paddiing
                    .padding(.bottom, Size.w(131))
                    .frame(maxWidth: reader.size.width)
                    .background(GeometryReader {
                        // calculate height by consumed background and store in
                        // view preference
                        Color.clear.preference(key: ViewHeightKey.self,
                                               value: $0.frame(in: .local).size.height) })
                }
                .onPreferenceChange(ViewHeightKey.self) {
                    self.fitInScreen = $0 < reader.size.height    // << here !!
                }
                .disabled(self.fitInScreen)
            }
        }
        .frame(alignment: .bottom)
        .frame(maxWidth: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                BackButton(action: {
            presentationMode.wrappedValue.dismiss()
        }, color: Color.yellow300))
    }
}
