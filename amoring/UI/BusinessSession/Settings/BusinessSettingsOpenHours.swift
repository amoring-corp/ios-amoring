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
    
    @State var weekDaysDisabled: Bool = false
    @State var weekEndsDisabled: Bool = false
    
    @State private var sunday: BusinessHours = BusinessHours(day: .sunday, openAt: Date(), closeAt: Date())
    @State private var monday: BusinessHours = BusinessHours(day: .sunday, openAt: Date(), closeAt: Date())
    
    @State var selectedDays: [Int?] = [0,0,0,0,0,0,0]
    
    
    @State private var businessHours: [BusinessHours] = [
        BusinessHours(day: .sunday, openAt: Date().startOfDay, closeAt: Date().startOfDay),
        BusinessHours(day: .monday, openAt: Date().startOfDay, closeAt: Date().startOfDay),
    ]
    @State private var businessHoursSaving: [BusinessHours] = []
    
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
//                                daysButton(me: .custom)
                            }
                            
                            switch daysSelection {
                            case .everyday:
                                VStack(alignment: .leading) {
                                    Text("➊ 영업시간을 알려주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    HStack(spacing: 0) {
                                        ZStack {
                                            DatePicker("", selection: $sunday.openAt, displayedComponents: .hourAndMinute)
                                                .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                                                .frame(height: Size.w(58))
                                            timeWindow(time: sunday.openAt).allowsHitTesting(false)
                                                .onChange(of: sunday.openAt) { date in
                                                    print(date)
                                                }
                                        }
                                        Text("~")
                                            .font(regular16Font)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, Size.w(20))
                                        ZStack {
                                            DatePicker("", selection: $sunday.closeAt, displayedComponents: .hourAndMinute)
                                                .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                                                .frame(height: Size.w(58))
                                            timeWindow(time: sunday.closeAt).allowsHitTesting(false)
                                        }
                                    }
                                }
                                .padding(.horizontal, Size.w(14))
                            case .weekAndOff:
                                VStack(alignment: .leading) {
                                    Text("➊ 평일 영업시간을 알려주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    
                                    HStack(spacing: 0) {
                                        ZStack {
                                            DatePicker("", selection: $monday.openAt, displayedComponents: .hourAndMinute)
                                                .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                                                .frame(height: Size.w(58))
                                                .opacity(weekDaysDisabled ? 0 : 1)
                                                
                                            timeWindow(time: monday.openAt).allowsHitTesting(false)
                                        }
                                        Text("~")
                                            .font(regular16Font)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, Size.w(20))
                                        ZStack {
                                            DatePicker("", selection: $monday.closeAt, displayedComponents: .hourAndMinute)
                                                .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                                                .frame(height: Size.w(58))
                                                .opacity(weekDaysDisabled ? 0 : 1)
                                            timeWindow(time: monday.closeAt).allowsHitTesting(false)
                                        }
                                    }
                                    .disabled(weekDaysDisabled)
                                    .opacity(weekDaysDisabled ? 0.2 : 1)
                                    
                                    Button(action: {
                                        if weekEndsDisabled && !weekDaysDisabled {
                                            weekDaysDisabled.toggle()
                                            weekEndsDisabled.toggle()
                                        } else {
                                            weekDaysDisabled.toggle()
                                        }
                                    }) {
                                        HStack(spacing: 0) {
                                            Image(systemName: weekDaysDisabled ? "checkmark.square.fill" : "square")
                                                .font(medium22Font)
                                            Text("휴무일 입니다.")
                                        }
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    }
                                    .padding(.vertical, Size.w(10))
                                }
                                .padding(.horizontal, Size.w(14))
                                
                                Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
                                    .padding(.vertical, Size.w(10))
                                
                                VStack(alignment: .leading) {
                                    Text("➊ 주말 영업시간을 알려주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                               
                                    HStack(spacing: 0) {
                                        ZStack {
                                            DatePicker("", selection: $sunday.openAt, displayedComponents: .hourAndMinute)
                                                .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                                                .frame(height: Size.w(58))
                                                .opacity(weekEndsDisabled ? 0 : 1)
                                            timeWindow(time: sunday.openAt).allowsHitTesting(false)
                                        }
                                        Text("~")
                                            .font(regular16Font)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, Size.w(20))
                                        ZStack {
                                            DatePicker("", selection: $sunday.closeAt, displayedComponents: .hourAndMinute)
                                                .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                                                .frame(height: Size.w(58))
                                                .opacity(weekEndsDisabled ? 0 : 1)
                                            timeWindow(time: sunday.closeAt).allowsHitTesting(false)
                                        }
                                    }
                                    .disabled(weekEndsDisabled)
                                    .opacity(weekEndsDisabled ? 0.2 : 1)
                                    
                                    Button(action: {
                                        if weekDaysDisabled && !weekEndsDisabled {
                                            weekDaysDisabled.toggle()
                                            weekEndsDisabled.toggle()
                                        } else {
                                            weekEndsDisabled.toggle()
                                        }
                                    }) {
                                        HStack(spacing: 0) {
                                            Image(systemName: weekEndsDisabled ? "checkmark.square.fill" : "square")
                                                .font(medium22Font)
                                            Text("휴무일 입니다.")
                                        }
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    }
                                    .padding(.vertical, Size.w(10))
                                }
                                .padding(.horizontal, Size.w(14))
                            case .custom:
                                ForEach(0..<businessHours.count) { index in
                                    VStack(alignment: .leading) {
                                        Text("➊ 해당되는 요일은 선택해주세요.")
                                            .font(medium14Font)
                                            .foregroundColor(.yellow600)
                                        
                                        DayWeekSelection(selectedDays: $selectedDays, number: index)
                                        
                                        Text("➋ 위 선택된 요일의 영업시간을 알려주세요.")
                                            .font(medium14Font)
                                            .foregroundColor(.yellow600)
                                        
                                        HStack(spacing: 0) {
                                            TimeWindow(time: $businessHours[index].openAt)
                                            Text("~")
                                                .font(regular16Font)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, Size.w(20))
                                            TimeWindow(time: $businessHours[index].closeAt)
                                        }
                                    }
                                    .padding(.horizontal, Size.w(14))
                                    
                                    Button(action: {
                                        if weekDaysDisabled && !weekEndsDisabled {
                                            weekDaysDisabled.toggle()
                                            weekEndsDisabled.toggle()
                                        } else {
                                            weekEndsDisabled.toggle()
                                        }
                                    }) {
                                        HStack(spacing: 0) {
                                            Image(systemName: weekEndsDisabled ? "checkmark.square.fill" : "square")
                                                .font(medium22Font)
                                            Text("휴무일 입니다.")
                                        }
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    }
                                    .padding(.vertical, Size.w(10))
                                }
                                
//                                Button(action: {
//                                    withAnimation {
//                                        self.businessHours.append(BusinessHours(day: DayOfWeek.byIndex(self.businessHours.count), openAt: self.businessHours[0].openAt, closeAt: self.businessHours[0].closeAt))
//                                    }
//                                }) {
//                                    Text("요일 추가하기")
//                                        .font(medium14Font)
//                                        .foregroundColor(.yellow300)
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: Size.w(51))
//                                        .background(Color.yellow500)
//                                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 10).stroke(Color.yellow600)
//                                        )
//                                }
                            }
                            
                            
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
                        Button(action: save) {
                            FullSizeButton(title: "저장", color: .black, bg: .yellow200, isLoading: userManager.isLoading, loadingColor: .gray1000)
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
        .onAppear {
            if let businessHours = userManager.user?.business?.businessHours, !businessHours.isEmpty {
                if businessHours.allEqual(by: \.openAt) && businessHours.allEqual(by: \.closeAt) && businessHours.count >= 7 {
                    self.sunday = businessHours.first!
                    self.monday = businessHours.first!
                } else {
//                    self.daysSelection = .custom
//                    // TODO: it kind of works but need sunday to be first day
//                    if let (first, second) = findTwoNotEqualBusinessHours(businessHours) {
//                        
//                        self.sunday = first
//                        self.monday = second
//                        self.businessHours[0] = first
//                        self.businessHours[1] = second
//                        for index in 0..<businessHours.count {
//                            if businessHours[index].openAt == first.openAt && businessHours[index].closeAt == first.closeAt {
//                                self.selectedDays[index] = 0
//                            } else if businessHours[index].openAt == second.openAt && businessHours[index].closeAt == second.closeAt {
//                                self.selectedDays[index] = 1
//                            }
//                        }
//                    } else {
//                        print("All objects in the array are equal.")
//                        self.sunday = businessHours.first!
//                        self.monday = businessHours.first!
//                    }
                    
                    
                    self.daysSelection = .weekAndOff
                    
                    self.sunday = businessHours.last!
                    self.monday = businessHours.first(where: { $0.closeAt != self.sunday.closeAt || $0.openAt != self.sunday.openAt }) ?? self.sunday
                    
                    if !businessHours.contains(where: { $0.day == .sunday }) {
                        self.weekEndsDisabled = true
                    }
                    if !businessHours.contains(where: { $0.day == .monday }) {
                        self.weekDaysDisabled = true
                    }
                }
            }
        }
    }
    
    private func save() {
        switch daysSelection {
        case .everyday:
            self.businessHoursSaving = [
                BusinessHours(day: .sunday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .monday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .tuesday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .wednesday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .thursday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .friday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .saturday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt)
            ]
        case .weekAndOff:
            businessHoursSaving.removeAll()
            
            if weekDaysDisabled {
                self.businessHoursSaving = [
                    BusinessHours(day: .sunday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                    BusinessHours(day: .saturday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt)
                ]
            } else if weekEndsDisabled {
                self.businessHoursSaving = [
                    BusinessHours(day: .monday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .tuesday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .wednesday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .thursday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .friday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                ]
            } else {
                self.businessHoursSaving = [
                    BusinessHours(day: .sunday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                    BusinessHours(day: .monday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .tuesday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .wednesday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .thursday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .friday, openAt: self.monday.openAt, closeAt: self.monday.closeAt),
                    BusinessHours(day: .saturday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt)
                ]
            }
        case .custom:
            for i in 0..<selectedDays.count {
                if let day = selectedDays[i] {
                    businessHoursSaving.append(BusinessHours(day: DayOfWeek.byIndex(i), openAt: businessHours[day].openAt, closeAt: businessHours[day].closeAt))
                }
            }
        }
        
        userManager.deleteAllBusinessHours{ success in
            if success {
                userManager.batchUpsertBusinessHours(hours: businessHoursSaving) {
                    success in
                    
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
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

func findTwoNotEqualBusinessHours(_ array: [BusinessHours]) -> (BusinessHours, BusinessHours)? {
    for i in 0..<array.count {
        for j in (i + 1)..<array.count {
            if array[i].openAt != array[j].openAt || array[i].closeAt != array[j].closeAt {
                return (array[i], array[j])
            }
        }
    }
    return nil
}
