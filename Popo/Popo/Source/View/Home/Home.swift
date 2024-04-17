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
    @State var showRegisterSheet: Bool = false
    @State var viewDidLoad: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                popoList
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
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
            .fullScreenCover(isPresented: $showRegisterSheet) {
                PopoRegist()
                    .presentationDetents([.large])
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
                            ForEach(firstLine) { popo in
                                NavigationLink {
                                    PopoDetail()
                                } label: {
                                    PopoCard(popo: popo,
                                             width: cardWidth,
                                             height: popo.height)
                                }.contextMenu {
                                    Button(action: {
                                        // 여기에 첫 번째 메뉴 항목을 눌렀을 때의 액션을 정의
                                        print("첫 번째 메뉴 액션 실행")
                                    }) {
                                        Label("첫 번째 메뉴", systemImage: "star")
                                    }
                                    
                                    Button(action: {
                                        // 여기에 두 번째 메뉴 항목을 눌렀을 때의 액션을 정의
                                        print("두 번째 메뉴 액션 실행")
                                    }) {
                                        Label("두 번째 메뉴", systemImage: "flag")
                                    }
                                }
                                
                            }
                        }
                        .frame(width: cardWidth)
                        VStack(spacing: 8) {
                            ForEach(secondLine) { popo in
                                NavigationLink {
                                    PopoDetail()
                                } label: {
                                    PopoCard(popo: popo,
                                             width: cardWidth,
                                             height: popo.height)
                                }.contextMenu {
                                    Button(action: {
                                        // 여기에 첫 번째 메뉴 항목을 눌렀을 때의 액션을 정의
                                        print("첫 번째 메뉴 액션 실행")
                                    }) {
                                        Label("첫 번째 메뉴", systemImage: "star")
                                    }
                                    
                                    Button(action: {
                                        // 여기에 두 번째 메뉴 항목을 눌렀을 때의 액션을 정의
                                        print("두 번째 메뉴 액션 실행")
                                    }) {
                                        Label("두 번째 메뉴", systemImage: "flag")
                                    }
                                }
                            }
                        }
                        .frame(width: cardWidth)
                    }
                }
            }
            .contentMargins([.top, .bottom], 16, for: .scrollContent)
            
        }
        .onAppear {
            viewDidLoad = true
            searchText = ""
        }
        .onChange(of: modelData.popos.count) { _, _ in
            withAnimation(.easeInOut) {
                modelData.sortPopos(sortType: sortType)
                setHeights()
            }
        }
        .onChange(of: searchText) { _, _ in
            withAnimation(.easeInOut) {
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
        let heights = Popo.setHeights(filteredPopos)
        
        for i in filteredPopos.indices {
            guard let index = modelData.popos.firstIndex(of: filteredPopos[i]) else { return }
            modelData.popos[index].height = heights[i]
        }
    }
}

#Preview {
    Home()
        .environmentObject(ModelData())
}
