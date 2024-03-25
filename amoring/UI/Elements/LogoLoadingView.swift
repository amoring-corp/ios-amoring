//
//  LogoLoadingView.swift
//  amoring
//
//  Created by 이준녕 on 12/29/23.
//

import SwiftUI

struct LogoLoadingView: View {
    @State var animation1: Bool = false
    @State var animation2: Bool = false
    @State var animation3: Bool = false
    @State var animation4: Bool = false
    @State var animation5: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            TickerLine(background: Color.yellow900)
                .offset(y: Size.w(-200))
                .rotationEffect(.degrees(-45))
                .opacity(animation1 ? 1 : 0.01)
            
            TickerLine(background: Color.yellow900)
                .rotationEffect(.degrees(25 + 180))
                .opacity(animation2 ? 1 : 0.01)
            
            TickerLine(background: Color.yellow900)
                .offset(y: Size.w(200))
                .rotationEffect(.degrees(-30))
                .opacity(animation3 ? 1 : 0.01)
            
            TickerLine()
                .offset(y: Size.w(200))
                .rotationEffect(.degrees(10))
                .opacity(animation4 ? 1 : 0.01)
            
            TickerLine()
                .offset(y: Size.w(-250))
                .rotationEffect(.degrees(-10))
                .opacity(animation5 ? 1 : 0.01)
            
            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 211, height: 182)
                .shadow(color: .black.opacity(0.8), radius: 10, y: 10)
            
            VStack(spacing: 0) {
                Spacer()
                Text("@mellowingfactory")
                    .font(regular14Font)
                    .foregroundColor(.yellow350)
                Text(Constants.version)
//                Text("v. \(Constants.version) build \(Constants.build)")
                    .font(regular14Font)
                    .foregroundColor(.yellow350)
                    .padding(.bottom, 30)
            }
        }
        ///  size of navigation view? after loading screen
        .padding(.top, 38)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color.gray1000.ignoresSafeArea())
        .onAppear(perform: runAnimation)
    }
    
    private func runAnimation() {
        if !animation1 {
            withAnimation(.default.delay(0.5)) {
                animation1 = true
            }
            withAnimation(.default.delay(1)) {
                animation2 = true
            }
            withAnimation(.default.delay(1.5)) {
                animation3 = true
            }
            withAnimation(.default.delay(2)) {
                animation4 = true
            }
            withAnimation(.default.delay(2.5)) {
                animation5 = true
            }
        }
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            backAnimation()
//        }
    }
    
    private func backAnimation() {
        withAnimation(.default.delay(0.5)) {
            animation5.toggle()
        }
        withAnimation(.default.delay(1)) {
            animation4.toggle()
        }
        withAnimation(.default.delay(1.5)) {
            animation3.toggle()
        }
        withAnimation(.default.delay(2)) {
            animation2.toggle()
        }
        withAnimation(.default.delay(2.5)) {
            animation1.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            runAnimation()
        }
    }
}

struct TickerLine: View {
    var background: Color = Color.yellow800
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<12) { _ in
                Text("AMORING")
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding(.vertical, 12)
        .font(semiBold14Font)
        .foregroundColor(.gray1000)
        .background(background)
        .shadow(color: .black.opacity(0.3), radius: 10, y: 10)
        .shadow(color: .black.opacity(0.3), radius: 40, y: 40)
        .drawingGroup()
    }
}

#Preview {
    LogoLoadingView()
}


struct LogoLoadingViewAsBG: View {
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .center) {
                TickerLine(background: Color.yellow900)
                    .offset(y: Size.w(-200))
                    .rotationEffect(.degrees(-45))
                    .opacity(1)
                
                TickerLine(background: Color.yellow900)
                    .rotationEffect(.degrees(25 + 180))
                    .opacity(1)
                
                TickerLine(background: Color.yellow900)
                    .offset(y: Size.w(200))
                    .rotationEffect(.degrees(-30))
                    .opacity(1)
                
                TickerLine()
                    .offset(y: Size.w(200))
                    .rotationEffect(.degrees(10))
                    .opacity(1)
                
                TickerLine()
                    .offset(y: Size.w(-250))
                    .rotationEffect(.degrees(-10))
                    .opacity(1)
            }
            
            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 211, height: 182)
                .shadow(color: .black.opacity(0.8), radius: 10, y: 10)
            
            VStack(spacing: 0) {
                Spacer()
                Text("@mellowingfactory")
                    .font(regular14Font)
                    .foregroundColor(.yellow350)
                Text(Constants.version)
                    .font(regular14Font)
                    .foregroundColor(.yellow350)
                    .padding(.bottom, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color.gray1000.ignoresSafeArea())
    }
}
