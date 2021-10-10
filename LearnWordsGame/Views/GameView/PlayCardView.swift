//
//  PlayCardView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct PlayCardView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isFaceUpForAll = false
    var body: some View {
        GeometryReader { g in
            VStack {
                HStack {
                    Spacer()
                    Button (action: {
                        isFaceUpForAll.toggle()
                    }){
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                            .font(.largeTitle)
                    }
                    .padding()
                }

                Spacer()
                HStack {
                    Spacer()
                    ZStack {
//MARK: - problem
                        Button("Перемешать") {
                            viewModel.gameStart()
                        }
                        ForEach(viewModel.cardsGame.shuffled()) { card in
                            GameCard(frame: g.frame(in: .global), card: card, isFaceUpForAll: $isFaceUpForAll)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(Color.black)
        }
    }
   
}


