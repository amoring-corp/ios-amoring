//
//  SignInView.swift
//  amoring
//
//  Created by 이준녕 on 11/20/23.
//

import SwiftUI
import NavigationStackBackport

struct SignInView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject var navigator = NavigationAuthController()
    
    @State var animate = false
    @State var businessSheetPresented: Bool = false
    @State var emailSheetPresented: Bool = false
    
    @AppStorage("language") var language = UserDefaults.standard.string(forKey: "language") ?? "ko"
    
    var body: some View {
        NavigationStackBackport.NavigationStack(path: $navigator.path) {
            ZStack {
                LogoLoadingViewAsBG()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.smooth) {
                                animate = true
                            }
                        }
                    }
                
                ZStack(alignment: .bottom) {
                    if animate {
                        SignInSheet(businessSheetPresented: $businessSheetPresented, emailSheetPresented: $emailSheetPresented).environmentObject(navigator)
                        if businessSheetPresented {
                            BusinessSignInSheet()
                        } else if emailSheetPresented {
                            EmailSignInSheet()
                        }
                    }
                }
            }
            .navigationBarItems(leading:
                                    Text("AMORING")
                .font(bold20Font)
                .foregroundColor(.yellow300)
                .opacity(animate ? 1 : 0), 
                                trailing: businessSheetPresented || emailSheetPresented ?
                                    Button(action: {
                withAnimation {
                    self.businessSheetPresented = false
                    self.emailSheetPresented = false
                }
            }) {
                Text("돌아가기")
                    .font(medium16Font)
                    .foregroundColor(.yellow300)
            } : nil
            )
            .backport.navigationDestination(for: AuthPath.self) { screen in
                navigator.navigate(screen: screen)
            }
        }
        .onAppear {
            self.language = Locale.current.identifier
        }
    }
}

#Preview {
    SignInView()
}
