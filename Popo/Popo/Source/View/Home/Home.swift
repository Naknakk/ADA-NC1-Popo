//
//  Home.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import SwiftUI

struct Home: View {
    @State var searchText: String = ""
    @State var firstLineHeights: [CGFloat] = []
    @State var secondLineHeights: [CGFloat] = []
    @State var dummyPopos: [Popo] = Popo.dummyPopos
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                popoList
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    header
                }
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarButtons
                }
            }
            .searchable(text: $searchText)
        }
    }
}

extension Home {
    var header: some View {
        Text("Popo")
            .foregroundStyle(.popoBlack)
            .font(.title)
            .fontWeight(.bold)
    }
    
    var toolbarButtons: some View {
        HStack {
            Button {
                print("sort")
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
            
            Button {
                print("Add Person")
            } label: {
                Image(systemName: "person.badge.plus")
            }
        }
    }
    
    var firstLine: [Popo] {
        return dummyPopos.enumerated().filter{ $0.offset % 2 == 0 }.map{ $0.element }
    }
    
    var secondLine: [Popo] {
        return dummyPopos.enumerated().filter{ $0.offset % 2 != 0 }.map{ $0.element }
    }
    
    var popoList: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 12)
                        .foregroundStyle(.clear)
                    HStack(alignment: .top, spacing: 8) {
                        let cardWidth = (proxy.size.width - 24 - 8) / 2
                        
                        VStack(spacing: 8) {
                            ForEach(firstLine) { popo in
                                PopoCard(popo: popo, width: cardWidth, height: popo.height)
                            }
                        }
                        VStack(spacing: 8) {
                            ForEach(secondLine) { popo in
                                PopoCard(popo: popo, width: cardWidth, height: popo.height)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            setHeights()
        }
    }
}

extension Home {
    func setHeights() {
        var firstLineSum: CGFloat = 0.0
        var secondLineSum: CGFloat = 0.0
        
        for i in dummyPopos.indices {
            dummyPopos[i].height = CGFloat.random(in: 160...280)
            if (i % 2) == 0 {
                firstLineSum += dummyPopos[i].height
            } else {
                secondLineSum += dummyPopos[i].height
            }
        }
        
        let firstIsLong = firstLineSum > secondLineSum
        let offset = firstIsLong ? (secondLineSum+40)/firstLineSum : (firstLineSum+40)/secondLineSum
        
        for i in dummyPopos.indices {
            if firstIsLong && i % 2 == 0 {
                dummyPopos[i].height *= offset
            } else if !firstIsLong && i % 2 != 0 {
                dummyPopos[i].height *= offset
            }
        }
    }
}

#Preview {
    Home()
}
