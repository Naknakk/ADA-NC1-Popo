//
//  Home.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var sortType: SortType = .like
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                popoList
            }
            .background(Color.popoBrown30)
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
            sortButton
            addPersonButton
        }
    }
    
    var sortButton: some View {
        Menu {
            Picker("Menu picker", selection: $sortType) {
                ForEach(SortType.allCases, id: \.self) { sortType in
                    Text(sortType.text)
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
        }
    }
    
    var addPersonButton: some View {
        Button {
            print("Add Person")
        } label: {
            Image(systemName: "person.badge.plus")
        }
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
                                NavigationLink {
                                    PopoDetail()
                                } label: {
                                    PopoCard(popo: popo,
                                             width: cardWidth,
                                             height: popo.height)
                                }
                                
                            }
                        }
                        VStack(spacing: 8) {
                            ForEach(secondLine) { popo in
                                NavigationLink {
                                    PopoDetail()
                                } label: {
                                    PopoCard(popo: popo,
                                             width: cardWidth,
                                             height: popo.height)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut) {
                sortPopos()
                setHeights()
            }
        }
        .onChange(of: sortType) { _, _ in
            withAnimation(.easeInOut) {
                sortPopos()
                setHeights()
            }
        }
    }
}

extension Home {
    var firstLine: [Popo] {
        return modelData.popos.enumerated().filter{ $0.offset % 2 == 0 }.map{ $0.element }
    }
    
    var secondLine: [Popo] {
        return modelData.popos.enumerated().filter{ $0.offset % 2 != 0 }.map{ $0.element }
    }
    
    func setHeights() {
        let heights = Popo.setHeights(modelData.popos)
        
        for i in modelData.popos.indices {
            modelData.popos[i].height = heights[i]
        }
    }
    
    func sortPopos() {
        switch sortType {
        case .like :
            modelData.popos = SortType.sortByLikeAndName(modelData.popos)
        case .name:
            modelData.popos = SortType.sortByName(modelData.popos)
        case .latest:
            modelData.popos = SortType.sortByDate(modelData.popos)
        }
    }
}

#Preview {
    Home()
        .environmentObject(ModelData())
}
