//
//  Popo.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import Foundation
import SwiftUI

struct Popo: Identifiable {
    let id: UUID = UUID()
    var name: String = ""
    var image: Image = Image("Default")
    var keyword: String = ""
    var isLiked: Bool = false
    var modifiedDate: Date = Date()
    var height: CGFloat = CGFloat.random(in: 150...280)
    
    var likePriority: LikePriority {
        return isLiked ? LikePriority.high : LikePriority.low
    }
    
    static var dummyPopos: [Popo] = [
        Popo(name: "미니",
             image: Image("Mini"),
             keyword: "초록, 빈티지, 데이지, 사랑스러운 웃음",
             isLiked: true,
             modifiedDate: Date()),
        Popo(name: "나기",
             image: Image("Nagi"),
             keyword: "맨날잔대요, 피곤하세요?, 따봉",
             isLiked: true,
             modifiedDate: Date().addingTimeInterval(-3500)),
        Popo(name: "윤슬",
             image: Image("Yunmin"),
             keyword: "심리학과, 디자인공부 시작, 솝트, 사진, 브런치 작가, 바보래요",
             isLiked: true,
             modifiedDate: Date().addingTimeInterval(-5000)),
        Popo(name: "윈터",
             image: Image("Winter"),
             keyword: "박명수, 치어리딩마스터, 여행마스터, 바보래요;, 킹받즈",
             modifiedDate: Date().addingTimeInterval(-1500)),
        Popo(name: "레모니",
             image: Image("Lemony"),
             keyword: "에너지왕, 진짜 ENTP맞는듯?, 지각생수거반장, 광채..어린 눈",
             modifiedDate: Date().addingTimeInterval(-2000)),
        Popo(name: "키니",
             image: Image("Keenie"),
             keyword: "ENFP, 운동하면 생기가 없어지는, 하체왕, 열정왕, 디자인왕, 그냥왕",
             modifiedDate: Date().addingTimeInterval(-2500)),
        Popo(name: "티모",
             image: Image("Teemo"),
             keyword: "성심당의 딸, 야무진막내, 나 자는 사진 전문, 귀엽다.., 근데 사진은 똑바로 찍어줘.",
             modifiedDate: Date().addingTimeInterval(-3000)),
        Popo(name: "쿠미",
             image: Image("Kumi"),
             keyword: "댄동, 미소의세계, 빈티지 마스터, MZ사진왕, ENFP",
             modifiedDate: Date().addingTimeInterval(-2500)),
        Popo(name: "일이삼사오육칠팔구십",
             image: Image("Hantol"),
             keyword: "일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오",
             modifiedDate: Date().addingTimeInterval(-2500))
    ]
}

extension Popo {
    static func setHeights(_ input: [Popo]) -> [CGFloat] {
        var firstLineSum: CGFloat = 0.0
        var secondLineSum: CGFloat = 0.0
        var heights: [CGFloat] = Array(repeating: 0, count: input.count)
        
        for i in heights.indices {
            heights[i] = CGFloat.random(in: 160...280)
            if (i % 2) == 0 {
                firstLineSum += heights[i]
            } else {
                secondLineSum += heights[i]
            }
        }
        
        let firstIsLong = firstLineSum > secondLineSum
        let offset = firstIsLong ? (secondLineSum+40)/firstLineSum : (firstLineSum+40)/secondLineSum
        
        for i in heights.indices {
            if firstIsLong && i % 2 == 0 {
                heights[i] *= offset
            } else if !firstIsLong && i % 2 != 0 {
                heights[i] *= offset
            }
        }
        
        return heights
    }
}

enum LikePriority {
    case high, low
    
    static func > (lhs: LikePriority, rhs: LikePriority) -> Bool {
        if lhs == .high && rhs == .low {
            return true
        } else if lhs == .low && rhs == .high {
            return false
        } else {
            return false
        }
    }
}
