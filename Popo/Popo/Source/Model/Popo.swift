//
//  Popo.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import Foundation
import SwiftUI

struct Popo: Identifiable, Equatable {
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
             keyword: "심리학과, 디자인공부 시작, 솝트, 사진, 브런치작가, 바보래요",
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
        Popo(name: "한톨",
             image: Image("Hantol"),
             keyword: "디자이너, 개발자, 디발자중 최강, 혼자서도 잘해요, 둘이서도 잘해요",
             modifiedDate: Date().addingTimeInterval(-2500)),
        Popo(name: "타냐",
             image: Image("Tanya"),
             keyword: "샹냥한 ISTP, 멋진 붕붕이의 주인, 백준 라이벌"),
        Popo(name: "구리구리",
             image: Image("Guryss"),
             keyword: "ESTJ, 멋쟁이, 웹소소, 써멀구리스;;, 냥집사")
    ]
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
