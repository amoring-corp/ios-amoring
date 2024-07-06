//
//  CheckInView.swift
//  amoring
//
//  Created by 이준녕 on 12/6/23.
//

import SwiftUI
import NavigationStackBackport

struct CheckInView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var navigationController: NavigationController
    
    @State var torchIsOn = false
    @State var openResult = false
    @State var businessName: String = ""
    @State var id: String = ""
    @State var image: String? = nil
    
    /// height of bottom bar + padding
    let bottomSpacing = Size.w(75) + Size.w(16)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("QR코드를 스캔하여 체크인해주세요.")
                .font(medium16Font)
                .foregroundColor(.yellow300)
                .padding(.top, Size.w(16))
                .padding(.bottom, Size.w(20))
            
            CodeScannerView(codeTypes: [.qr], scanMode: .once, isTorchOn: $torchIsOn, completion: handleScan)
                .border(Color.yellow600)
            
            VStack(alignment: .leading, spacing: Size.w(7)) {
                Text("• 체크인은 3시간 동안 유효해요.")
                Text("• 유효기간 만료 후에는 QR코드를 재스캔해주세요.")
                Text("• 다른 매장에서 이용시, 체크 아웃 후 이용해주세요.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(light14Font)
            .foregroundColor(.yellow600)
            .padding(.vertical, Size.w(16))
            
            Spacer()
            
            NavigationLink(isActive: $openResult, destination: {
                CheckInResult(businessName: businessName, id: self.id, image: self.image)
                    .onAppear(perform: navigationController.hideBar)
                    .onDisappear(perform: navigationController.showBar)
            }) {
                EmptyView()
            }
        }
        .padding(.horizontal, Size.w(22))
        .padding(.bottom, Size.w(10))
        .padding(.bottom, bottomSpacing)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray1000)
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            userManager.createCheckInByToken(token: result.string) { error, business, id in
                if let business {
                    self.businessName = business.businessName ?? ""
                    self.id = id ?? ""
                    self.image = business.images?.first?.map({ $0.file?.url ?? "" })
                    openResult = true
                }
                if let error {
                    notificationController.setNotification(text: error, type: .error)
                }
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            notificationController.setNotification(text: error.localizedDescription, type: .error)
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
