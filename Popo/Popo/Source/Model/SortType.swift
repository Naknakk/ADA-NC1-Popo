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
    
    static func sortByLikeAndName(_ input: [Popo]) -> [Popo] {
        return input.sorted {
            $0.likePriority > $1.likePriority
        }.sorted {
            if ($0.likePriority, $1.likePriority) == (.high, .high) {
                return $0.name < $1.name
            } else if ($0.likePriority, $1.likePriority) == (.high, .low) {
                return false
            } else if ($0.likePriority, $1.likePriority) == (.low, .low) {
                return $0.name < $1.name
            } else {
                return false
            }
        }
    }
    
    static func sortByName(_ input: [Popo]) -> [Popo] {
       return input.sorted {
            $0.name < $1.name
        }
    }
    
    static func sortByDate(_ input: [Popo]) -> [Popo] {
        return input.sorted {
            $0.modifiedDate > $1.modifiedDate
        }
    }
}
