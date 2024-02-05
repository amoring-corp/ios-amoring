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
    
    @State var torchIsOn = false
    @State var openResult = false
    @State var resultString: String = ""
    
    /// height of bottom bar + padding
    let bottomSpacing = Size.w(75) + Size.w(16)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("QR코드를 스캔하여 체크인해주세요.")
                .font(medium16Font)
                .foregroundColor(.yellow300)
                .padding(.top, Size.w(16))
                .padding(.bottom, Size.w(20))
            
            CodeScannerView(codeTypes: [.qr], scanMode: .continuous, isTorchOn: $torchIsOn, completion: handleScan)
                .border(Color.yellow600)
            
            VStack(alignment: .leading, spacing: Size.w(7)) {
                Text("• QR코드는 실시간으로 업데이트 되기때문에 이미지는")
                Text("• 체크인은 2시간 동안 유효합니다.")
                Text("• 대표 주의사항")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(light14Font)
            .foregroundColor(.yellow600)
            .padding(.vertical, Size.w(16))
            
            Spacer()
            
            NavigationLink(isActive: $openResult, destination: {
                CheckInResult(resultString: self.resultString)
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
            print(result)
            self.resultString = result.string
            openResult = true
//            navigator.resultString = result.string
//            navigator.path.append(NavigatorPath.checkInResult)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
