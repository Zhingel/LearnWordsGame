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
    @State var textGameStart = false
    var body: some View {
        GeometryReader { g in
            VStack {
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        Button {
                            textGameStart.toggle()
                        } label: {
                            Image(systemName: textGameStart ?  "pencil.circle.fill" :  "pencil.circle")
                        }

                        Button (action: {
                            isFaceUpForAll.toggle()
                        }){
                            Image(systemName: "arrow.triangle.2.circlepath.circle")
                        }
                    }
                }
                .font(.largeTitle)
                .padding([.top,.trailing])
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        Button("Перемешать") {
                            viewModel.gameStart()
                        }
                        ForEach(viewModel.cardsGame) { card in
                            GameCard(frame: g.frame(in: .global), card: card, isFaceUpForAll: $isFaceUpForAll, textGameStart: $textGameStart)
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


