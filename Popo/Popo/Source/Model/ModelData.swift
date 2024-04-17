//
//  modelData.swift
//  Popo
//
//  Created by 이윤학 on 4/16/24.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var popos = Popo.dummyPopos
    
    
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
