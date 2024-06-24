//
//  NavigatorView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI

struct NavigatorView<Content: View>: View {
    @EnvironmentObject var amoringController: AmoringController
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    @StateObject var navigationController = NavigationController()
    
    @Binding var selectedIndex: Int
    let titles: [String] = TabBarType.allCases.map({ $0.tabTitle })
    
    @ViewBuilder let content: (Int) -> Content
    
    @State var showAlert = false
    @State var showInfo = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(titles.indices, id:\.self) { index in
                    content(index)
                        .tag(index)
                }
            }
            TabBarBottomView(tabbarTitles: titles, selectedIndex: $selectedIndex)
        }
        .ignoresSafeArea()
        .environmentObject(navigationController)
    }
}

struct TabBarBottomView: View {
    @EnvironmentObject var navigationController: NavigationController
    let tabbarTitles: [String]
    @Binding var selectedIndex: Int
    
    let height = Size.w(75)
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                ForEach(0..<tabbarTitles.count, id: \.self) { index in
                    tabButton(index: index)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: height)
            .padding(.bottom, (Size.safeArea().bottom != 0 ? Size.safeArea().bottom : 5))
            .background(Color.gray1000)
            .zIndex(2)
        }
        .offset(y: navigationController.barAppear ? 0 : 100)
    }
    
    @ViewBuilder
    func tabButton(index: Int) -> some View {
        let title = tabbarTitles[index]
        Button {
            if selectedIndex == index {
                // go to root
            } else {
                selectedIndex = index
            }
        } label: {
            let isSelected = selectedIndex == index
            let selected: String = isSelected ? "-selected" : ""
            let icon = "tab-icon" + String(index) + selected
            VStack(spacing: 5) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Size.w(30), height: Size.w(30))
                    .padding(.top, Size.h(3))
                Text(LocalizedStringKey(title))
                    .foregroundColor(isSelected ? .yellow200 : .gray600)
                    .font(regular14Font)
            }.frame(maxWidth: .infinity)
                .badge(1)
        }
    }
}

enum TabBarType: Int, CaseIterable {
    case nearby = 0
    case amoring
    case messages
    case account
    
    var tabTitle: String {
        switch self {
        case .nearby:
            return "navi.NEARBY"
        case .amoring:
            return "navi.LOUNGE"
        case .messages:
            return "navi.MESSAGES"
        case .account:
            return "navi.ACCOUNT"
        }
    }
}


//#Preview {
//    NavigatorView() { index in
//        
//    }
//}
