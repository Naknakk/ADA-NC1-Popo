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
    @State var viewDidLoad: Bool = false
    @State var needResort: Bool = false
    
    @State var showRegisterSheet: Bool = false
    @State var editTargetIndex: Int? = nil
    @State var editTargetPopo: Popo = Popo()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                popoList
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                Image("PopoBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
            .fullScreenCover(isPresented: $showRegisterSheet) {
                PopoRegist(popo: $editTargetPopo, editTargetIndex: $editTargetIndex, needResort: $needResort)
            }
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
            editTargetPopo = Popo()
            editTargetIndex = nil
            showRegisterSheet = true
        } label: {
            Image(systemName: "person.badge.plus")
        }
    }
    
    var popoList: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0)
                        .foregroundStyle(.clear)
                    HStack(alignment: .top, spacing: 8) {
                        let cardWidth = (proxy.size.width - 24 - 8) / 2
                        
                        VStack(spacing: 8) {
                            Rectangle()
                                .frame(height: 8)
                                .foregroundStyle(.clear)
                            ForEach(firstLine) { popo in
                                popoCell(popo: popo, width: cardWidth)
                            }
                        }
                        .frame(width: cardWidth)
                        
                        VStack(spacing: 8) {
                            Rectangle()
                                .frame(height: 8)
                                .foregroundStyle(.clear)
                            ForEach(secondLine) { popo in
                                popoCell(popo: popo, width: cardWidth)
                            }
                        }
                        .frame(width: cardWidth)
                    }
                }
            }
            .contentMargins(.bottom, 16, for: .scrollContent)
            
        }
        .onAppear {
            viewDidLoad = true
            withAnimation(.easeInOut) {
                modelData.sortPopos(sortType: sortType)
            }
        }
        .onChange(of: needResort) { oldValue, newValue in
            if needResort {
                withAnimation(.easeInOut) {
                    modelData.sortPopos(sortType: sortType)
                    setHeights()
                }
                needResort = false
            }
        }
        .onChange(of: searchText) { _, _ in
            withAnimation(.easeInOut(duration: 0.2)) {
                modelData.sortPopos(sortType: sortType)
                setHeights()
            }
        }
        .onChange(of: viewDidLoad) { _, _ in
            withAnimation(.easeInOut) {
                modelData.sortPopos(sortType: sortType)
                setHeights()
            }
        }
        .onChange(of: sortType) { _, _ in
            withAnimation(.easeInOut) {
                modelData.sortPopos(sortType: sortType)
                setHeights()
            }
        }
    }
    
    func popoCell(popo: Popo, width: CGFloat) -> some View {
        return NavigationLink {
            PopoDetail(popo: popo)
        } label: {
            PopoCard(popo: popo,
                     width: width,
                     height: popo.height)
        }.contextMenu {
            Button {
                modelData.toggleLike(of: popo)
                withAnimation {
                    modelData.sortPopos(sortType: sortType)
                }
            } label: {
                Label(popo.isLiked ? "즐겨찾기 해제" : "즐겨찾기 추가",
                      systemImage: popo.isLiked ? "star.slash" : "star")
            }
            
            Button {
                editTargetPopo = popo
                editTargetIndex = modelData.index(of: popo)
                showRegisterSheet = true
            } label: {
                Label("편집", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                modelData.delete(popo: popo)
            } label: {
                Label("삭제", systemImage: "trash")
            }
        }
    }
}

extension Home {
    var filteredPopos: [Popo] {
        if searchText.isEmpty {
            return modelData.popos
        } else {
            return modelData.popos.filter{
                $0.name.lowercased().localizedStandardContains(searchText.lowercased())
            }
        }
    }
    
    var firstLine: [Popo] {
        return filteredPopos.enumerated().filter{ $0.offset % 2 == 0 }.map{ $0.element }
    }
    
    var secondLine: [Popo] {
        return filteredPopos.enumerated().filter{ $0.offset % 2 != 0 }.map{ $0.element }
    }
    
    func setHeights() {
        let heights = setHeights(filteredPopos)
        
        for i in filteredPopos.indices {
            guard let index = modelData.popos.firstIndex(of: filteredPopos[i]) else { return }
            modelData.popos[index].height = heights[i]
        }
    }
    
    func setHeights(_ input: [Popo]) -> [CGFloat] {
        if input.count == 1 {
            return [170]
        }
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
        let offset = firstIsLong ? (secondLineSum+100)/firstLineSum : (firstLineSum+100)/secondLineSum
        
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

#Preview {
    Home()
        .environmentObject(ModelData())
}
