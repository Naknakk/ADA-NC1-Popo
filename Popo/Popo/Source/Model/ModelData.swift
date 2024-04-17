//
//  modelData.swift
//  Popo
//
//  Created by 이윤학 on 4/16/24.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var popos = Popo.dummyPopos
    
    func needResort(by popo: Popo, at index: Int) -> Bool {
        return popos[index].isLiked != popo.isLiked || popos[index].name != popo.name
    }
}

/// CRUD
extension ModelData {
    func updateBasicInfo(popo: Popo, index: Int) {
        popos[index].name = popo.name
        popos[index].keyword = popo.keyword
        popos[index].image = popo.image
        popos[index].isLiked = popo.isLiked
    }
    
    func create(popo: Popo) {
        popos.append(popo)
    }
    
    func delete(popo: Popo) {
        guard let index = index(of: popo) else { return }
        popos.remove(at: index)
    }
    
    func index(of popo: Popo) -> Int? {
        return popos.firstIndex(of: popo)
    }
    
    func toggleLike(of popo: Popo) {
        guard let index = index(of: popo) else { return }
        popos[index].isLiked.toggle()
    }
}

/// SORT
extension ModelData {
    func sortPopos(sortType: SortType) {
        switch sortType {
        case .like :
            sortPoposByLikeAndName()
        case .name:
            sortPoposByName()
        case .latest:
            sortPoposByDate()
        }
    }
    
    func sortPoposByLikeAndName() {
        popos.sort {
            if $0.likePriority == $1.likePriority {
                return $0.name < $1.name
            } else {
                return $0.likePriority > $1.likePriority
            }
        }
    }
    
    func sortPoposByName() {
    popos.sort{
            $0.name < $1.name
        }
    }
    
    func sortPoposByDate() {
        popos.sort{
            $0.modifiedDate > $1.modifiedDate
        }
    }
}
