//
//  BusinessSettingsOpenHours.swift
//  amoring
//
//  Created by 이준녕 on 1/25/24.
//

import SwiftUI

struct BusinessSettingsOpenHours: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager

    @State private var daysSelection: DaySelection = .everyday
    
    @State private var from0: Date = Date()
    @State private var from1: Date = Date()
    @State private var from2: Date = Date()
    @State private var from3: Date = Date()
    @State private var from4: Date = Date()
    @State private var from5: Date = Date()
    @State private var from6: Date = Date()
    
    @State private var to0: Date = Date()
    @State private var to1: Date = Date()
    @State private var to2: Date = Date()
    @State private var to3: Date = Date()
    @State private var to4: Date = Date()
    @State private var to5: Date = Date()
    @State private var to6: Date = Date()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: .constant(400), title: "영업시간", back: { presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: .constant(400)) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("아래의 내용은 비울 수 없습니다\n고객에게 홍보되는 정보이니 정확히 작성해주세요.")
                            .font(regular16Font)
                            .foregroundColor(.yellow600)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(40))
                            .padding(.bottom, Size.w(40))
                        
                        VStack(alignment: .leading) {
                            
                            Text("정기적으로 운영하시는 일자별 영업정보를 알려주세요.")
                                .font(medium14Font)
                                .foregroundColor(.yellow600)
                                .multilineTextAlignment(.center)
                                .padding(.leading, Size.w(14))
                                .padding(.top, Size.w(22))
                                .padding(.bottom, Size.w(10))
                            
                            HStack(spacing: 0) {
                                daysButton(me: .everyday)
                                daysButton(me: .weekAndOff)
                                daysButton(me: .custom)
                            }
                            
                            Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
                                .padding(.vertical, Size.w(10))
                            
                            VStack(alignment: .leading) {
                                Text("➊ 영업시간을 알려주세요.")
                                    .font(medium14Font)
                                    .foregroundColor(.yellow600)
                                
                                HStack(spacing: 0) {
                                    ZStack {
                                        DatePicker("", selection: $from0, displayedComponents: .hourAndMinute)
                                            .frame(height: Size.w(58))
                                        timeWindow(time: from0).allowsHitTesting(false)
                                    }
                                    Text("~")
                                        .font(regular16Font)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, Size.w(20))
                                    ZStack {
                                        DatePicker("", selection: $to0, displayedComponents: .hourAndMinute)
                                            .frame(height: Size.w(58))
                                        timeWindow(time: to0).allowsHitTesting(false)
                                    }
                                }
                            }
                            .padding(.horizontal, Size.w(14))
                            
                            Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
                                .padding(.vertical, Size.w(10))
                            
                        }
                        .padding(.bottom, Size.w(30))
                        
                        
                        Spacer().frame(height: 300)
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.yellow300)
                
                
                VStack(spacing: 0) {
                    Color.yellow200
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    HStack {
                        if userManager.isLoading {
                            ProgressView()
                                .tint(.black)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                        } else {
                            Button(action: {
                                if let business = userManager.user?.business {
                                    var edited = business
                                    edited.open = from0
                                    edited.close = to0
                                    userManager.upsertMyBusiness(business: edited) { success in
                                        print(edited)
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }) {
                                FullSizeButton(title: "저장", color: .black, bg: .yellow200, loadingColor: .gray1000)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, Size.w(16))
                    .padding(.horizontal, Size.w(22))
                }
                .padding(.bottom, Size.w(36))
                .background(Color.yellow300)
                .shadow(color: Color.black.opacity(0.1), radius: 50, y: -20)
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func daysButton(me: DaySelection) -> some View {
        let selected = me == self.daysSelection
        Text(me.title())
            .font(medium15Font)
            .foregroundColor(selected ? .gray100 : .yellow600)
            .frame(maxWidth: .infinity)
            .frame(height: Size.w(50))
            .background(selected ? Color.yellow700 : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(selected ? Color.yellow800 : Color.yellow600)
            )
            .padding(Size.w(8))
            .onTapGesture {
                withAnimation {
                    self.daysSelection = me
                }
            }
    }
    
    @ViewBuilder
    private func timeWindow(time: Date) -> some View {
        Text(time.toHM())
            .font(medium18Font)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: Size.w(58))
            .background(Color.gray100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    BusinessSettingsOpenHours()
}
