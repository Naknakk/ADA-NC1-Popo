//
//  PopoCard.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import SwiftUI

struct PopoCard: View {
    let popo: Popo
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            Image(popo.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
               
            
            LinearGradient(colors: [.black.opacity(0.75), .black.opacity(0)],
                           startPoint: .bottom,
                           endPoint: .center)
            
            VStack(alignment: .leading) {
                Text(popo.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(popo.keyword)
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundStyle(.white.opacity(0.80))
                    .lineLimit(2)
            }
            .padding([.horizontal], 8)
            .padding(.bottom, 8)
        }
        .frame(width: width, height: height)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    PopoCard(popo: Popo.dummyPopos[0], width: 173.5, height: 300)
    
}
