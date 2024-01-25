//
//  BusinessPurchaseView.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessPurchaseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selection: PurchasePlan = .basic
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TickerLine()
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .clipped()
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Size.w(84), height: Size.w(84))
            }
            .padding(.top, Size.w(35))
            .padding(.bottom, Size.w(23))
            
            Text("비즈니스 멤버십")
                .font(bold28Font)
                .foregroundColor(.gray150)
                .padding(.bottom, Size.w(10))
            
            Text("라운지 확장을 위해서는\n비즈니스 멤버십 구독이 필요합니다.")
                .font(medium14Font)
                .foregroundColor(.gray600)
                .multilineTextAlignment(.center)
                .padding(.bottom, Size.w(40))
            
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.yellow300)
                    .frame(width: Size.w(20), height: Size.w(2))
            }
//            .frame(width: Size.w(60), height: Size.w(2), alignment: .trailing)
            .frame(width: Size.w(60), height: Size.w(2), alignment: selection == .basic ? .leading : (selection == .business ? .center : .trailing))
            .background(Color.gray800)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding(.bottom, Size.w(20))
            
            TabView(selection: $selection.animation()) {
                ForEach(PurchasePlan.allCases, id: \.self) { plan in
                    PurchasePlanView(plan: plan)
                        .id(plan)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color.gray1000)
            .padding(.bottom, Size.w(27))
            
            Button(action: {
                
            }) {
                Text("결제하기")
                    .font(semiBold22Font)
                    .foregroundColor(.black)
                    .padding(.vertical, Size.w(22))
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow300)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray1000)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading:
                                BackButton(action: back, color: Color.yellow300)
        )
    }
    
    private func back() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

enum PurchasePlan: CaseIterable {
    case basic, business, premium
    
    func title() -> String {
        switch self {
        case .basic:
            "Basic"
        case .business:
            "Business"
        case .premium:
            "Premium+"
        }
    }
    
    func price() -> String {
        switch self {
        case .basic:
            "₩ 100,000"
        case .business:
            "₩ 200,000"
        case .premium:
            "₩ 400,000"
        }
    }
}

struct PurchasePlanView: View {
    let plan: PurchasePlan
    
    var body: some View {
        VStack(spacing: 0) {
            Text(plan.title())
                .font(semiBold18Font)
                .foregroundColor(.black)
                .padding(.vertical, Size.w(16))
                .frame(maxWidth: .infinity)
                .background(Color.yellow200)
                .padding(.bottom, Size.w(20))
            
            HStack {
                Text("한달에")
                    .font(regular16Font)
                    .foregroundColor(.gray700)
                Spacer()
                Text(plan.price())
                    .font(bold22Font)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, Size.w(20))
            .padding(.bottom, Size.w(20))
            
            Color.gray200.frame(maxWidth: .infinity).frame(height: 1)
                .padding(.bottom, Size.w(10))
            
            HStack {
                Text("라운지 인원")
                    .font(medium16Font)
                    .foregroundColor(.gray600)
                Spacer()
                
                Text(plan != .basic ? "무제한" : "30 명")
                    .font(bold18Font)
                    .foregroundColor(.yellow600)
                
                if plan != .basic {
                    Image(systemName: "infinity")
                        .font(bold18Font)
                        .foregroundColor(.yellow350)
                }
            }
            .padding(Size.w(12))
            .background(Color.yellow350.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, Size.w(8))
            .padding(.bottom, Size.w(6))
            
            HStack {
                Text("광고 제거")
                    .font(medium16Font)
                    .foregroundColor(.gray600)
                
                Spacer()
                
                if plan != .basic {
                    Image(systemName: "checkmark")
                        .font(bold18Font)
                        .foregroundColor(.yellow350)
                }
            }
            .padding(Size.w(12))
            .background(Color.yellow350.opacity(plan != .premium ? 0 : 0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, Size.w(8))
            .padding(.bottom, Size.w(6))
            
            HStack {
                Text("검색 시 상단 노출")
                    .font(medium16Font)
                    .foregroundColor(.gray600)
                
                Spacer()
                
                if plan != .basic {
                    Image(systemName: "checkmark")
                        .font(bold18Font)
                        .foregroundColor(.yellow350)
                }
            }
            .padding(Size.w(12))
            .background(Color.yellow350.opacity(plan != .premium ? 0 : 0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, Size.w(8))
            .padding(.bottom, Size.w(22))
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, Size.w(52))
        .padding(.vertical, Size.w(20))
    }
}

#Preview {
    BusinessPurchaseView()
}

