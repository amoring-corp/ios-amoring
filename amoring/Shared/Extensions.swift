//
//  Extensions.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import SwiftUI

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func timeToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

//        let item = "7:00 PM"
//        print("Start: \(date)") // Start: Optional(2000-01-01 19:00:00 +0000)
        return dateFormatter.date(from: self)
    }
}

extension Optional where Wrapped == String {
    var isNil: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Double {
    var isNil: Bool {
        return self == nil
    }
    
    func toWeight() -> String? {
        self.isNil ? nil : Int(self!).description + "kg"
    }
    func toHeight() -> String? {
        self.isNil ? nil : Int(self!).description + "cm"
    }
}

extension Date {
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension Optional where Wrapped == Date {
    var isNil: Bool {
        return self == nil
    }
    
    func toTime() -> String {
        if let self {
            let formatter = DateFormatter()
            formatter.dateFormat = "a hh:mm"
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone.current
            formatter.amSymbol = "오전"
            formatter.pmSymbol = "오후"
            return formatter.string(from: self)
        } else {
            return ""
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
//    func customSheet<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
//
//    }
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension UINavigationController {
    // MARK: Allows to Swipe to go back for Navigation View even when stock Back Button is hidden
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

extension Double {
    func secondsToHMS() -> (Int, Int, Int) {
        return (Int(self) / 3600, (Int(self) % 3600) / 60, (Int(self) % 3600) % 60)
    }
}

extension Optional where Wrapped == TimeInterval {
    func toString() -> String {
        if let self {
            let HMS = self.secondsToHMS()
            return "\(String(format: "%02d", HMS.0)):\(String(format: "%02d", HMS.1))"
//            return "\(String(format: "%02d", HMS.0)):\(String(format: "%02d", HMS.1)):\(String(format: "%02d", HMS.2))"
        } else {
            return ""
        }
    }
}

extension TimeInterval {
    func toPassedTime() -> String {
        if self < 61 {
            return "지금"
        } else if self > 86400 {
            return "만료됨"
        } else {
            let HMS = self.secondsToHMS()
            let hours = HMS.0 > 0 ? "\(HMS.0)시간 " : ""
            let minutes = HMS.1 > 0 ? "\(HMS.1)분 " : ""
            return  hours + minutes + "전"
        }
    }
    
    func toEraseTime() -> String {
        let HMS = self.secondsToHMS()
        
        if HMS.0 >= 0 {
            return "\(HMS.0 + 1)시간 후 메시지가 사라집니다."
        } else {
            return "1 시간 후 메시지가 사라집니다."
        }
    }
}
