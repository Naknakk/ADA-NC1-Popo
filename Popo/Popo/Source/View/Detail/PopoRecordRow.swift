//
//  PopoRecordRow.swift
//  Popo
//
//  Created by 이윤학 on 4/18/24.
//

import SwiftUI

struct PopoRecordRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            textRecord
            imageRecord
            Divider()
                .padding(.horizontal, 12)
            bottomSection
            
        }
        .background(.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.popoBlack.opacity(0.6), lineWidth: 2.0)
        }
        
        .padding()
    }
}

extension PopoRecordRow {
    var textRecord: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("기록 제목")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.popoBlack)
            Text("기록 내용 기록 내용 기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용기록 내용")
                .font(.subheadline)
                .foregroundStyle(.popoBlack.opacity(0.6))
        }
        .padding([.top, .horizontal], 12)
    }
    
    var imageRecord: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                ForEach(0..<9) { _ in
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 75, height: 70)
                        .foregroundStyle(.popoBlack.opacity(0.4))
                }
            }
        }
        .contentMargins([.leading, .trailing], 12, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
    
    var bottomSection: some View {
        HStack {
            Text("2024년 4월 18일 목요일")
                .font(.caption)
                .foregroundStyle(.popoBlack.opacity(0.6))
            Spacer()
            Button {
                print("More")
            } label: {
                Image(systemName: "ellipsis")
                    .font(.body)
                    .foregroundStyle(.popoBlack.opacity(0.6))
            }
        }
        .padding([.horizontal, .bottom], 12)
    }
}

#Preview {
    PopoRecordRow()
}
