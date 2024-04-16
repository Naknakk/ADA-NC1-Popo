//
//  PopoApp.swift
//  Popo
//
//  Created by 이윤학 on 4/15/24.
//

import SwiftUI
import SwiftData

@main
struct PopoApp: App {
    @StateObject var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
