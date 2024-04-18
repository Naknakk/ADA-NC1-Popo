//
//  PopoDetail.swift
//  Popo
//
//  Created by 이윤학 on 4/16/24.
//

import SwiftUI

struct PopoDetail: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var modelData: ModelData
    
    @State var showSheet = false
    @State var isEditing = false
    var popo: Popo
    let imageHeight: CGFloat = 360
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                banner
                ForEach(0..<10) { _ in
                    PopoRecordRow(showSheet: $showSheet, isEditing: $isEditing)
                }
            }
        }
        .fullScreenCover(isPresented: $showSheet, content: {
            PopoRecordRegist(isEditing: $isEditing)
        })
        .background {
            Image("PopoBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .ignoresSafeArea(edges: [.top, .horizontal])
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 4) {
                    likeButton
                    addRecordButton
                }
                
            }
        }
        .background(Color.popoBrown30)
    }
}

extension PopoDetail {
    var banner: some View {
        ZStack(alignment: .bottomLeading) {
            popo.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: imageHeight)
                .clipped()
            LinearGradient(colors: [.popoBlack.opacity(0.8), .popoBlack.opacity(0)],
                           startPoint: .bottom,
                           endPoint: .center)
            RadialGradient(colors: [.popoBlack.opacity(0), .popoBlack.opacity(0.6)],
                           center: .center,
                           startRadius: imageHeight/4,
                           endRadius: imageHeight)
            description
                .padding([.leading, .trailing], 16)
                .padding(.bottom, 16)
        }
        
    }
    
    var description: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom, spacing: 6) {
                Text(popo.name)
                    .font(.system(size: 44))
                    .fontWeight(.bold)
                    .foregroundStyle(.popoBrown30)
                    .lineLimit(1)
            }
            
            Text(popo.keyword)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundStyle(.popoBrown30.opacity(0.80))
        }
    }
    var likeButton: some View {
        Button {
            modelData.toggleLike(of: popo)
        } label: {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 36, height: 36)
                .foregroundStyle(.popoGreen.opacity(0.8))
                .overlay {
                    Image(systemName: modelData.popos[modelData.index(of: popo) ?? 0].isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.popoBrown30)
                        .shadow(color: .popoBlack.opacity(0.4), radius: 1)
                }
        }
    }

    var addRecordButton: some View {
        Button {
            showSheet = true
            isEditing = false
            print("add")
        } label: {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 36, height: 36)
                .foregroundStyle(.popoGreen.opacity(0.8))
                .overlay {
                    Image(systemName: "pencil")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.popoBrown30)
                        .shadow(color: .popoBlack.opacity(0.4), radius: 1)
                }
        }
    }
    var backButton: some View {
        Button {
            dismiss()
        } label : {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 36, height: 36)
                .foregroundStyle(.popoGreen.opacity(0.8))
                .overlay {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.popoBrown30)
                        .shadow(color: .popoBlack.opacity(0.4), radius: 1)
                }
        }
    }
}

#Preview {
    PopoDetail(popo: ModelData().popos[2])
        .environmentObject(ModelData())
}
