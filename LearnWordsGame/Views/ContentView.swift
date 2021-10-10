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
                    Image(systemName: "rectangle.on.rectangle")
                    Text("Карточки")
                }
            AllCardCollection()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Коллекция")
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

