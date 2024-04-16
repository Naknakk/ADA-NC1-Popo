//
//  Popo.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import Foundation

struct Popo: Identifiable {
    let id: UUID = UUID()
    var name: String
    var imageName: String
    var keyword: String
    
    var height: CGFloat = CGFloat.random(in: 150...280)
    
    static var dummyPopos: [Popo] = [
        Popo(name: "미니",
             imageName: "Mini",
             keyword: "초록, 빈티지, 데이지, 사랑스러운 웃음"),
        Popo(name: "나기",
             imageName: "Nagi",
             keyword: "맨날잔대요, 피곤하세요?, 따봉"),
        Popo(name: "윤슬",
             imageName: "Yunmin",
             keyword: "심리학과, 디자인공부 시작, 솝트, 사진, 브런치 작가, 바보래요"),
        Popo(name: "윈터",
             imageName: "Winter",
             keyword: "박명수, 치어리딩마스터, 여행마스터, 바보래요;, 킹받즈"),
        Popo(name: "레모니",
             imageName: "Lemony",
             keyword: "에너지왕, 진짜 ENTP맞는듯?, 지각생수거반장, 광채..어린 눈"),
        Popo(name: "키니",
             imageName: "Keenie",
             keyword: "ENFP, 운동하면 생기가 없어지는, 하체왕, 열정왕, 디자인왕, 그냥왕"),
        Popo(name: "티모",
             imageName: "Teemo",
             keyword: "성심당의 딸, 야무진막내, 나 자는 사진 전문, 귀엽다.., 근데 사진은 똑바로 찍어줘."),
        Popo(name: "쿠미",
             imageName: "Kumi",
             keyword: "댄동, 미소의세계, 빈티지 마스터, MZ사진왕, ENFP")
    ]
}
