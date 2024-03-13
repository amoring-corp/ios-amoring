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
    
    @Binding var selectedIndex: Int
    let titles: [String] = TabBarType.allCases.map({ $0.tabTitle })
    
    @ViewBuilder let content: (Int) -> Content
    
    @State var showAlert = false
    
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                setTitle()
            }
        }
        .navigationBarItems(
            leading: setLeading(),
            trailing: setTrailing()
        )
    }
    
    @ViewBuilder
    func setTitle() -> some View {
        let title =
        Text("AMORING")
            .font(bold20Font)
            .foregroundColor(.yellow300)
        switch selectedIndex {
        case 0:
            title
        case 1:
            if amoringController.checkIn == nil {
                title
            } else {
                EmptyView()
            }
        case 2:
            title
        case 3: EmptyView()
        default: EmptyView()
        }
    }
    
    @ViewBuilder
    func setTrailing() -> some View {
        let infoButton = Button(action: {
            print(UserDefaults.standard.string(forKey: "BOO"))
        }) {
            Image("ic-info")
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(32), height: Size.w(32))
        }
        
        switch selectedIndex {
        case 0:
            infoButton
        case 1:
            if amoringController.checkIn == nil {
                infoButton
            } else {
                HStack {
                    Text(amoringController.countDown.toString())
                        .font(medium16Font)
                        .foregroundColor(.yellow300)
                        .fixedSize(horizontal: true, vertical: false)
                        .lineLimit(1)
                    Button(action: {
                        showAlert = true
                    }) {
                        Image("ic-leave-room")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Size.w(32), height: Size.w(32))
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("체크아웃하기"),
                              message: Text("라운지 체크아웃 시\n프로필이 더 이상 소개되지 않습니다.\n라운지에서 체크아웃 하시겠습니까?"),
                              primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("확인"), action: leave))
                    }
                }
            }
        case 2: infoButton
        case 3: EmptyView()
        default: EmptyView()
        }
    }
    
    @ViewBuilder
    func setLeading() -> some View {
        switch selectedIndex {
        case 0:
            EmptyView()
        case 1:
            if amoringController.checkIn != nil {
                Text("AMORING")
                .font(bold20Font)
                .foregroundColor(.yellow300)
            } else {
                EmptyView()
            }
        case 2: EmptyView()
        case 3: EmptyView()
        default: EmptyView()
        }
    }
    
    func leave() {
        userManager.checkOutFromActive { error in
            if let error {
                notificationController.setNotification(text: error, type: .error)
            } else {
                amoringController.leave()
            }
        }
    }
}


struct TabBarBottomView: View {
    
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
//        .offset(y: navigator.path.isEmpty ? 0 : 100)
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
            return "navi.AMORING"
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
