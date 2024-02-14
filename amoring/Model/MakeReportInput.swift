//
//  MakeReportInput.swift
//  amoring
//
//  Created by 이준녕 on 2/14/24.
//

import Foundation
import AmoringAPI

struct ReportInput {
    let body: String
    let email: String
    let subject: String
    let type: ReportType
    
    enum ReportType: String {
        case inquiry, report
    }
    
    var data: MakeReportInput {
        let report = MakeReportInput(InputDict([
            "body": body,
            "email": email,
            "subject": subject,
            "type": type.rawValue,
        ]))
        
        return report
    }
}
