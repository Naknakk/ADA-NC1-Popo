//
//  modelData.swift
//  Popo
//
//  Created by 이윤학 on 4/16/24.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var popos = Popo.dummyPopos
}
