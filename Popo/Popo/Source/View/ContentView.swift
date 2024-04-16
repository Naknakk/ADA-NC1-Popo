//
//  ContentView.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
