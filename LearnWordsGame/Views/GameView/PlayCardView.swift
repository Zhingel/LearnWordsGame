//
//  PlayCardView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct PlayCardView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { g in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
//MARK: - problem
                        Button("Перемешать") {
                            viewModel.gameStart()
                        }
                        ForEach(viewModel.cardsGame.shuffled()) { card in
                            GameCard(frame: g.frame(in: .global), card: card)
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


