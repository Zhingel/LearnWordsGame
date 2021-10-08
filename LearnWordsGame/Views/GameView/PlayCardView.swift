//
//  PlayCardView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct PlayCardView: View {
    @State var refresh = false
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
                            refresh.toggle()
                        }
                        ForEach(viewModel.cardsGame.shuffled()) { card in
                            GameCard(frame: g.frame(in: .global), card: card)
                        }
                        
                        if !refresh {
                            ForEach(viewModel.cardsGame.shuffled()) { card in
                                GameCard(frame: g.frame(in: .global), card: card)
                            }
                        }
                        if refresh {
                            ForEach(viewModel.cardsGame.shuffled()) { card in
                                GameCard(frame: g.frame(in: .global), card: card)
                            }
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

struct PlayCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayCardView()
    }
}
