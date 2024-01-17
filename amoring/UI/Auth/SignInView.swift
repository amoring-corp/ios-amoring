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
                .opacity(animate ? 1 : 0), 
                                trailing: businessSheetPresented ?
                                    Button(action: {
                withAnimation {
                    self.businessSheetPresented = false
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
    }
}

#Preview {
    SignInView()
}
