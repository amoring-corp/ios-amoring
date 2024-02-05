//
//  BusinessOnboardingStep2.swift
//  amoring
//
//  Created by 이준녕 on 1/12/24.
//

import SwiftUI

struct BusinessOnboardingStep2: View {
    @EnvironmentObject var controller: BusinessOnboardingController
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var notificationController: NotificationController
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var businessName: String = ""
    @State var representativeTitle: String = ""
    @State var businessType: String = ""
    @State var businessCategory: String = "클럽"
    @State var address: String = ""
    @State var registrationNumber: String = ""
    @State var phoneNumber: String = ""
    
    @State var next: Bool = false
    @State var presentImporter: Bool = false
    @State var typesSheetPresented: Bool = false
    @State var contentOffset: CGFloat = 0
    
    @State private var pictures: [PictureModel] = []
    @State private var droppedOutside: Bool = false
    @State private var confirmRemoveImageIndex: Int = 0
    @State private var showRemoveConfirmation: Bool = false
    @State private var showContentTypeSheet: Bool = false
    @State private var showPermissionDenied: Bool = false
    @State private var editIndex: Int? = nil
    
    @State private var daysSelection: DaySelection = .everyday
    @State var selectedDays: [Bool] = [false, true, true, true, true, true, false]
    @State var unselectedDays: [Bool] = [true, false, false, false, false, false, true]
    @State private var sunday: BusinessHours = BusinessHours(day: .sunday, openAt: Date(), closeAt: Date())
    @State private var monday: BusinessHours = BusinessHours(day: .sunday, openAt: Date(), closeAt: Date())
//    @State private var monday: (Int, Date, Date) = (1, Date(), Date())
//    @State private var tuesday: (Int, Date, Date) = (2, Date(), Date())
//    @State private var wednesday: (Int, Date, Date) = (3, Date(), Date())
//    @State private var thirsday: (Int, Date, Date) = (4, Date(), Date())
//    @State private var friday: (Int, Date, Date) = (5, Date(), Date())
//    @State private var saturday: (Int, Date, Date) = (6, Date(), Date())
    
    @State var businessHours: [BusinessHours] = []
    
    @State var showPhoneCodes = false
    @State var selectedCode: String = "010"
    

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CustomNavigationView(offset: $contentOffset, title: "매장정보", back: { presentationMode.wrappedValue.dismiss() })
                TrackableScrollView(showIndicators: false, contentOffset: $contentOffset) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("매장을 홍보하세요")
                            .font(bold32Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.top, Size.w(56))
                            .padding(.bottom, Size.w(10))
                        
                        Text("아래의 내용은 ***전부 필수**로 입력하셔야 합니다.\n고객에게 노출되는 정보이니 정확히 작성해주세요.\n나중에 매장정보에서 수정도 가능합니다.")
                            .font(regular16Font)
                            .foregroundColor(.black)
                            .padding(.horizontal, Size.w(14))
                            .padding(.bottom, Size.w(40))
                            
                            PickerButton(title: "분류*") {
                                if let businessCategory = controller.business.businessCategory {
                                    Text(businessCategory)
                                        .foregroundColor(.black)
                                        .font(medium18Font)
                                }
                            } 
                            .onTapGesture {
                                withAnimation {
                                    typesSheetPresented.toggle()
                                }
                            }
//                        }
                        .padding(.bottom, Size.w(30))

                        VStack(alignment: .leading) {
                            Text("전화번호*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                                .onChange(of: controller.business.bio ?? "", perform: { newValue in
                                    if(newValue.count >= 150){
                                        controller.business.bio = String(newValue.prefix(150))
                                    }
                                })
                            
                            MultilineCustomTextField(placeholder: "고객들이 회원님의 매장을 잘 이해할 수 있도록 간단한 소개 부탁드립니다. 소개는 150자 이하로 부탁드립니다.", text: $controller.business.bio ?? "")

                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("전화번호*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            HStack {
                                SmallPickerButton {
                                    Text(selectedCode)
                                        .foregroundColor(.black)
                                        .font(medium18Font)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        showPhoneCodes.toggle()
                                    }
                                }
                                
                                CustomTextField(placeholder: "‘-’ 표시없이 입력해주세요.", text: $phoneNumber, font: regular18Font, keyboardType: .phonePad)
                                    .onChange(of: phoneNumber, perform: { newValue in
                                        if(newValue.count >= 1){
                                            controller.business.phoneNumber = selectedCode + newValue
                                        } else {
                                            controller.business.phoneNumber = nil
                                        }
                                    })
                                    .onChange(of: selectedCode, perform: { newValue in
                                        controller.business.phoneNumber = newValue + phoneNumber
                                    })
                            }
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("영업시간*")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                            
                            Text("정기적으로 운영하시는 일자별 영업정보를 알려주세요.")
                                .font(medium14Font)
                                .foregroundColor(.yellow600)
                                .padding(.leading, Size.w(14))
                                .padding(.top, Size.w(22))
                                .padding(.bottom, Size.w(10))
                            
                            HStack(spacing: 0) {
                                daysButton(me: .everyday)
                                daysButton(me: .weekAndOff)
//                                daysButton(me: .custom)
                            }
    
                            Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
                                .padding(.vertical, Size.w(10))
    
                            switch daysSelection {
                            case .everyday:
                                VStack(alignment: .leading) {
                                    Text("➊ 영업시간을 알려주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    // TODO: Implement saving
                                    HStack(spacing: 0) {
                                        ZStack {
                                            DatePicker("", selection: $sunday.openAt, displayedComponents: .hourAndMinute)
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
                                                .frame(height: Size.w(58))
                                            timeWindow(time: sunday.closeAt).allowsHitTesting(false)
                                        }
                                    }
                                }
                                .padding(.horizontal, Size.w(14))
                            case .weekAndOff:
                                VStack(alignment: .leading) {
                                    Text("➊ 해당되는 요일은 선택해주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    
                                    DayWeekSelection(selectedDays: $selectedDays)
                                    
                                    Text("➋ 위 선택된 요일의 영업시간을 알려주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    
                                    HStack(spacing: 0) {
                                        ZStack {
                                            DatePicker("", selection: $sunday.openAt, displayedComponents: .hourAndMinute)
                                                .frame(height: Size.w(58))
                                            timeWindow(time: sunday.openAt).allowsHitTesting(false)
                                        }
                                        Text("~")
                                            .font(regular16Font)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, Size.w(20))
                                        ZStack {
                                            DatePicker("", selection: $sunday.closeAt, displayedComponents: .hourAndMinute)
                                                .frame(height: Size.w(58))
                                            timeWindow(time: sunday.closeAt).allowsHitTesting(false)
                                        }
                                    }
                                }
                                .padding(.horizontal, Size.w(14))
                                
                                Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
                                    .padding(.vertical, Size.w(10))
                                
                                VStack(alignment: .leading) {
                                    Text("➊ 해당되는 요일은 선택해주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    
                                    DayWeekSelection(selectedDays: $unselectedDays)
                                    
                                    Text("➋ 위 선택된 요일의 영업시간을 알려주세요.")
                                        .font(medium14Font)
                                        .foregroundColor(.yellow600)
                                    
                                    HStack(spacing: 0) {
                                        ZStack {
                                            DatePicker("", selection: $monday.openAt, displayedComponents: .hourAndMinute)
                                                .frame(height: Size.w(58))
                                            timeWindow(time: monday.openAt).allowsHitTesting(false)
                                        }
                                        Text("~")
                                            .font(regular16Font)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, Size.w(20))
                                        ZStack {
                                            DatePicker("", selection: $monday.closeAt, displayedComponents: .hourAndMinute)
                                                .frame(height: Size.w(58))
                                            timeWindow(time: monday.closeAt).allowsHitTesting(false)
                                        }
                                    }
                                }
                                .padding(.horizontal, Size.w(14))
                                .onChange(of: selectedDays) { selectedDays in
                                    self.unselectedDays = selectedDays.map { !$0 }
                                }
                                .onChange(of: unselectedDays) { unselectedDays in
                                    self.selectedDays = unselectedDays.map { !$0 }
                                }
                            case .custom:
                                Text("CUSTOM")
                            }
                            
                            
                            Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
                                .padding(.vertical, Size.w(10))
                            
//                            Button(action: {
//                                controller.business.businessName = "BOO"
//                                controller.business.address = "BOO"
//                                userManager.upsertMyBusiness(business: controller.business) { success in }
//                            }) {
//                                FullSizeButton(title: "CREATE BUSINESS")
//                            }
//                            
//                            Color.yellow600.frame(maxWidth: .infinity).frame(height: Size.w(1))
//                                .padding(.vertical, Size.w(10))
//                            
//                            
//                            Button(action: saveBusinessHours) {
//                                FullSizeButton(title: "TRY TO SAVE HOURS")
//                            }
                        }
                        .padding(.bottom, Size.w(30))
                        
                        VStack(alignment: .leading) {
                            Text("사진* (최소 3개이상)")
                                .font(regular16Font)
                                .foregroundColor(.black)
                                .padding(.leading, Size.w(14))
                           
                            PictureGridView(pictures: $pictures, droppedOutside: $droppedOutside, onAddedImageClick: { index in
                                confirmRemoveImageIndex = index
                                showRemoveConfirmation.toggle()
                            }, onAddImageClick: {
                                showContentTypeSheet.toggle()
                            })
                            .padding(.horizontal, Size.w(-8))
                        }
                        .padding(.bottom, Size.w(30))
                        .sheet(isPresented: $showContentTypeSheet) {
                            ImagePicker(pictures: $pictures, photoIndex: editIndex).ignoresSafeArea()
                                .onDisappear {
                                    self.editIndex = nil
                                }
                        }
                        .actionSheet(isPresented: $showRemoveConfirmation) {
                            if confirmRemoveImageIndex >= 3 {
                                ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                                    .default(Text("등록"), action: {
                                        self.editIndex = confirmRemoveImageIndex
                                        showContentTypeSheet.toggle()
                                    }),
                                    .destructive(Text("삭제"), action: removePicture),
                                    .cancel()
                                ])
                            } else {
                                ActionSheet(title: Text("프로필 사진 추가"), message: Text("회원가입을 위해 최소 3개의 사진이 필요합니다."), buttons: [
                                    .default(Text("등록"), action: {
                                        self.editIndex = confirmRemoveImageIndex
                                        showContentTypeSheet.toggle()
                                    }),
                                    .cancel()
                                ])
                            }
                        }
                        
                        
                        Spacer().frame(height: 300)
                        
                        NavigationLink(isActive: $next, destination: {
                            BusinessOnboardingSuccess()
                        }) {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, Size.w(22))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.yellow300)
                
                
                VStack(spacing: 0) {
                    Color.yellow200
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    let pass =
                    !((controller.business.businessCategory?.isEmpty) == nil)
                    && !((controller.business.bio?.isEmpty) == nil)
                    && !((controller.business.phoneNumber?.isEmpty) == nil)
//                    && !((controller.business.open?.isEmpty) == nil)
//                    && !((controller.business.close?.isEmpty) == nil)
                    && self.pictures.count > 2
                    
                    HStack {
                        Button(action: save) {
                            FullSizeButton(title: "가입하기", enabled: pass, isLoading: userManager.isLoading)
                        }
                        .disabled(!pass)
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
        .onTapGesture {
            withAnimation {
                showPhoneCodes = false
                typesSheetPresented = false
            }
            closeKeyboard()
        }
        .overlay(
            typesSheetPresented ? CustomSheet {
                Picker("", selection: $businessCategory) {
                    ForEach(Constants.businessTypes, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.wheel)
                .onAppear {
                    withAnimation {
                        controller.business.businessCategory = self.businessCategory
                    }
                }
                .onChange(of: businessCategory) { newValue in
                    withAnimation {
                        controller.business.businessCategory = self.businessCategory
                    }
                }
            } : nil
        )
        .overlay(
            showPhoneCodes ? CustomSheet {
                Picker("", selection: $selectedCode) {
                    ForEach(Constants.phoneCodeList, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.wheel)
            } : nil
        )
    }
    
    private func removePicture() {
        pictures.remove(at: confirmRemoveImageIndex)
    }
    
    private func save() {
        userManager.upsertMyBusiness(business: controller.business) { success in
            guard let data = controller.data else { return }
            self.saveBusinessHours()
            userManager.uploadBusinessRegistrationFile(data: data) { success in
                let images = pictures.map({ $0.picture })
                userManager.uploadBusinessImages(images: images) { success in
                    if success {
                        userManager.upsertMyBusiness(business: controller.business) { success in
                            print(userManager.user?.business)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                if success {
                                    self.next = success
                                } else {
                                    notificationController.setNotification(text: "Something went wrong while updating profile. Please try again", type: .error)
                                }
                            }
                        }
                    } else {
                        notificationController.setNotification(text: "Something went wrong while uploading images. Please try again", type: .error)
                    }
                }
            }
        }
    }
    
    private func saveBusinessHours() {
        switch self.daysSelection {
        case .everyday:
            controller.businessHours = [
                BusinessHours(day: .sunday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .monday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .tuesday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .wednesday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .thursday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .friday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt),
                BusinessHours(day: .saturday, openAt: self.sunday.openAt, closeAt: self.sunday.closeAt)
            ]
     
        case .weekAndOff:
            for index in 0..<selectedDays.count {
                if selectedDays[index] {
                    let hours = BusinessHours(day: DayOfWeek.byIndex(index), openAt: sunday.openAt, closeAt: sunday.closeAt)
                    controller.businessHours.append(hours)
                }
            }
            for index in 0..<unselectedDays.count {
                if unselectedDays[index] {
                    let hours = BusinessHours(day: DayOfWeek.byIndex(index), openAt: monday.openAt, closeAt: monday.closeAt)
                    controller.businessHours.append(hours)
                }
            }
            
        case .custom:
            print("ds")
        }
        
        userManager.batchUpsertBusinessHours(data: controller.businessHours) {
            success in
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
            .background(Color.yellow700.opacity(selected ? 1 : 0.01))
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
    BusinessOnboardingStep2()
}

struct DayWeekSelection: View {
    @Binding var selectedDays: [Bool]
    
    var body: some View {
        HStack(spacing: Size.w(10)) {
            ForEach(0..<Constants.daysOfWeek.count, id: \.self) { index in
                DayOfWeekView(title: Constants.daysOfWeek[index], selected: selectedDays[index])
                    .onTapGesture {
                        withAnimation {
                            selectedDays[index].toggle()
                        }
                    }
            }
        }
        .padding(.vertical, Size.w(10))
    }
}

struct DayOfWeekView: View {
    var title: String
    var selected: Bool
    
    var body: some View {
        Text(title)
            .font(medium15Font)
            .foregroundColor(selected ? .gray100 : .yellow600)
            .frame(width: Size.w(38), height: Size.w(50))
            .background(selected ? Color.yellow700 : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(selected ? Color.yellow800 : Color.yellow600)
            )
    }
}

enum DaySelection {
    case everyday, weekAndOff, custom
    
    func title() -> String {
        switch self {
        case .everyday:
            return "매일"
        case .weekAndOff:
            return "평일/주말"
        case .custom:
            return "요일별"
        }
    }
}
