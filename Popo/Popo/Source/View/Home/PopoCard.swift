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
            ZStack(alignment: .topTrailing) {
                background
                if popo.isLiked {
                    likeSymbol
                }
            }
            description
        }
        .frame(width: width, height: height)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

extension PopoCard {
    var background: some View {
        ZStack {
            popo.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
            
            LinearGradient(colors: [.popoBlack.opacity(0.6), .popoBlack.opacity(0)],
                           startPoint: .bottom,
                           endPoint: .center)
            
            RadialGradient(colors: [.popoBlack.opacity(0), .popoBlack.opacity(0.6)],
                           center: .center,
                           startRadius: width/4,
                           endRadius: (width+height)/2)
        }
    }
    
    var likeSymbol: some View {
        RoundedRectangle(cornerRadius: 9)
            .frame(width: 24, height: 24)
            .foregroundStyle(.popoPink)
            .overlay {
                Image(systemName: "heart.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(.popoBrown30)
                    .shadow(color: .popoBlack.opacity(0.4), radius: 1)
            }
            .padding(8)
    }
    
    var description: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom, spacing: 6) {
                Text(popo.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.popoBrown30)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
               
            }
            
            Text(popo.keyword)
                .font(.caption)
                .fontWeight(.regular)
                .foregroundStyle(.popoBrown30.opacity(0.80))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .padding([.horizontal], 8)
        .padding(.bottom, 8)
    }
}

#Preview {
    PopoCard(popo: Popo.dummyPopos[0], width: 173.5, height: 300)
    
}
