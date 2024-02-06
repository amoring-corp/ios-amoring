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
    @Binding var address: String
    @Binding var district: String
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
                print(data["jibunAddress"])
                print(data["bname"])
                DispatchQueue.main.async {
                    self.parent.address = data["jibunAddress"] as? String ?? ""
                    self.parent.district = data["bname"] as? String ?? ""
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
        
        let gitURL = URL(string: "https://sergeymellowing.github.io/Kakao-Postcode/")!
        let url = gitURL
        let request = URLRequest(url: url)
        _wkwebview.load(request)
        return _wkwebview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
