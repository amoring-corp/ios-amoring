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
    
    var body: some View {
        ZStack {
            if sessionManager.goToUserOnboarding {
                UserOnboardingView()
                    .transition(.move(edge: .trailing))
            } else {
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
                        
                        ZStack(alignment: .topLeading) {
                            if animate {
                                SignInSheet(businessSheetPresented: $businessSheetPresented).environmentObject(navigator)
                                if self.businessSheetPresented {
                                    BusinessSignInSheet()
                                }
                            }
                        }
                    }
                    .navigationBarItems(leading:
                                            Text("AMORING")
                        .font(bold20Font)
                        .foregroundColor(.yellow300)
                        .opacity(animate ? 1 : 0), trailing:
                                            Button(action: {
                        withAnimation {
                            self.businessSheetPresented = false
                        }
                    }) {
                        Text("돌아가기")
                            .font(medium16Font)
                            .foregroundColor(.yellow300)
                    }
                    )
                    .backport.navigationDestination(for: AuthPath.self) { screen in
                        navigator.navigate(screen: screen)
                    }
                }
            }
        }
    }
}

#Preview {
    SignInView()
}
