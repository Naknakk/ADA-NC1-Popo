//
//  SortType.swift
//  Popo
//
//  Created by 이윤학 on 4/16/24.
//

import Foundation

enum SortType: String, CaseIterable {
    case like, name, latest
    
    var text: String {
        switch self {
        case .like: "즐겨찾기"
        case .name: "이름"
        case .latest: "최근 등록한 항목"
        }
    }
    
    
}
