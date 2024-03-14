//
//  MKWebView.swift
//  amoring
//
//  Created by 이준녕 on 1/31/24.
//

import SwiftUI
import UIKit
import WebKit

struct PostCodeServiceView: UIViewRepresentable {
    @Binding var business: Business
    
    @Binding var isOpened: Bool
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        let parent: PostCodeServiceView

        init(_ parent: PostCodeServiceView) {
            self.parent = parent
        }
        
        var webView: WKWebView?
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
        }
        
        // receive message from wkwebview
        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            print("✅✅✅✅✅")
            if let data = message.body as? [String: Any] {
                DispatchQueue.main.async {
                    self.parent.business.address = data["address"] as? String ?? ""
                    self.parent.business.addressBname = data["bname"] as? String ?? ""
                    self.parent.business.addressJibun = data["jibunAddress"] as? String ?? ""
                    self.parent.business.addressSido = data["sido"] as? String ?? ""
                    self.parent.business.addressSigungu = data["sigungu"] as? String ?? ""
                    self.parent.business.addressSigunguCode = data["sigunguCode"] as? String ?? ""
                    self.parent.business.addressSigunguEnglish = data["sigunguEnglish"] as? String ?? ""
                    self.parent.business.addressZonecode = data["zonecode"] as? String ?? ""
                    self.parent.isOpened = false
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let coordinator = makeCoordinator()
        let userContentController = WKUserContentController()
        userContentController.add(coordinator, name: "callBackHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let _wkwebview = WKWebView(frame: .zero, configuration: configuration)
        _wkwebview.navigationDelegate = coordinator
        
        let url = URL(string: "https://amoring-be.antonmaker.com/kakao-address/ios")!
        let request = URLRequest(url: url)
        _wkwebview.load(request)
        return _wkwebview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
