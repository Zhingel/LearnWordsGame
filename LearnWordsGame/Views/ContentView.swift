//
//  ContentView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        TabView {
            PlayCardView()
                .tabItem {
                    Text("First")
                }
            AllCardCollection()
                .tabItem {
                    Text("Second")
                        
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

