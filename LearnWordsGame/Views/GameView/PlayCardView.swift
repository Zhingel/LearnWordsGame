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
                            Image(systemName: isFaceUpForAll ? "arrow.triangle.2.circlepath.circle.fill" :
                                    "arrow.triangle.2.circlepath.circle")
                        }
                    }
                    .foregroundColor(.purple)
                    .padding(.top, 40)
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
                        .foregroundColor(.purple)
                        .padding()
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .gray, radius: 4, x: 5, y: -5)
                        ForEach(viewModel.cardsGame) { card in
                            GameCard(frame: g.frame(in: .global), card: card, isFaceUpForAll: $isFaceUpForAll, textGameStart: $textGameStart)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .background(Color("backGroundColor"))
        }
        .edgesIgnoringSafeArea(.top)
    }
   
}


