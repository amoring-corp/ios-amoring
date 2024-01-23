//
//  mbti.swift
//  amoring
//
//  Created by 이준녕 on 12/15/23.
//

import Foundation

enum mbtiE: String, Codable, CaseIterable {
    case ESTJ, ENTJ, ESFJ, ENFJ, ISTJ, ISFJ, INTJ, INFJ, ESTP, ESFP, ENTP, ENFP, ISTP, ISFP, INTP, INFP
    
    static func withLabel(_ label: String) -> mbtiE? {
        return self.allCases.first{ "\($0)" == label }
    }
}
