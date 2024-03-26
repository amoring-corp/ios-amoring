//
//  Extensions.swift
//  amoring
//
//  Created by 이준녕 on 11/22/23.
//

import SwiftUI

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date.addingTimeInterval(TimeInterval(TIME_OFFSET))
        } else {
            return Date()
        }
    }
    
    func HMSStringtoDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
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
    
    func checkTextSufficientComplexity(regEx: String) -> Bool {
        let texttest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return texttest.evaluate(with: self)
    }
    
    func containsUppercase() -> Bool {
        checkTextSufficientComplexity(regEx: ".*[A-Z]+.*")
    }
    
    func containsLowercase() -> Bool {
        checkTextSufficientComplexity(regEx: ".*[a-z]+.*")
    }
    
    func containsSpecialCharacters() -> Bool {
        checkTextSufficientComplexity(regEx: ".*[!&^%$#@()/]+.*")
    }
    
    func containsNumbers() -> Bool {
        checkTextSufficientComplexity(regEx: ".*[0-9]+.*")
    }
    
    func isStrongPassword() -> Bool {
        self.count >= 8 && containsUppercase() && containsLowercase() && containsSpecialCharacters() && containsNumbers()
    }
    
    func isEmailValid() -> Bool {
        do {
            let range = NSRange(location: 0, length: self.utf16.count)
            let regex = try NSRegularExpression(pattern: "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
            return regex.firstMatch(in: self, options: [], range: range) != nil && !self.isEmpty
        } catch {
            return false
        }
    }
}

extension Optional where Wrapped == String {
    var isNil: Bool {
        return self == nil
    }
}

extension Optional where Wrapped == Int {
    var isNil: Bool {
        return self == nil
    }
    
    func toWeight() -> String? {
        self.isNil ? nil : self!.description + "kg"
    }
    func toHeight() -> String? {
        self.isNil ? nil : self!.description + "cm"
    }
}

extension Int {
    func toWeight() -> String {
        self.description + "kg"
    }
    func toHeight() -> String? {
        self.description + "cm"
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
    
    func toHM(timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale.current
        formatter.timeZone = timeZone
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.amSymbol = "오전"
        formatter.pmSymbol = "오후"
        return formatter.string(from: self)
    }
    
    func toHMS() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }
    
    var startOfDay: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
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
    
    /// handling overlaying alerts!
    public func alertPatched(isPresented: Binding<Bool>, content: () -> Alert) -> some View {
        self.overlay(
            EmptyView().alert(isPresented: isPresented, content: content),
            alignment: .bottomTrailing
        )
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
    
    func toExpiredTime() -> String {
        let HMS = self.secondsToHMS()
        let hours = HMS.0 > 0 ? "\(HMS.0)시간 " : ""
        let minutes = HMS.1 > 0 ? "\(HMS.1)분 " : ""
        return  hours + minutes + "남음"
    }
}

extension Collection {
    func allEqual<T: Equatable>(by key: KeyPath<Element, T>) -> Bool {
        return allSatisfy { first?[keyPath:key] == $0[keyPath:key] }
    }
}

extension UNNotificationAttachment {
    static func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let folderName = ProcessInfo.processInfo.globallyUniqueString
        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
            try data.write(to: fileURL!, options: [])
            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
            return attachment
        } catch let error {
            print("error \(error)")
        }
        
        return nil
    }
}

func secondElement<T>(of array: [T]) -> T? {
    guard array.count >= 2 else {
        return nil
    }
    return array[1]
}
