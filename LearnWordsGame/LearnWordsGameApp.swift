//
//  LearnWordsGameApp.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

@main
struct LearnWordsGameApp: App {
    @StateObject var viewModel: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
