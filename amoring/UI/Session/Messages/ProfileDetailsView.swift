//
//  ProfileDetailsView.swift
//  amoring
//
//  Created by 이준녕 on 6/24/24.
//

import SwiftUI
import AmoringAPI

struct ProfileDetailsView: View {
    @Namespace var animation
    
    let profile: ProfileInfo
    
    @State private var fitInScreen = false
    @State private var showDetails = false
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
                                        width: reader.size.width - Size.w(showDetails ? 20 : 44),
                                        height: reader.size.height - heightPadding
                        )
                        
                        ExpandedView(profile: profile)
                    }
                    .background(Color.yellow350)
                    .frame(
                        maxWidth: reader.size.width - Size.w(showDetails ? 20 : 44),
                        /// bottom bar + 56paddiing + 44navbar + saveAreaBottom
                        maxHeight: showDetails ? .infinity : reader.size.height - heightPadding, alignment: .top)
                    .cornerRadius(24)
                    /// bottom bar + 56paddiing
                    .padding(.bottom, showDetails ? Size.w(131) : 0)
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
                .onChange(of: showDetails) { bool in
                    self.heightPadding = bool ? Size.w(75) : Size.w(131)
                }
            }
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.smooth) {
                        showDetails.toggle()
                    }
                }
            }
        }
        .frame(alignment: .bottom)
    }
}

//#Preview {
//    SwipibleProfileVIew(user: Dummy.users.first!, swipeAction: .constant(.doNothing), onSwiped: { _,_  in })
//}

