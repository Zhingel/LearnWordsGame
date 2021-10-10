//
//  GameCard.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct GameCard: View {
    var frame: CGRect
    @EnvironmentObject var viewModel: ViewModel
    @State var card: Card
    @State var offsetCard: CGFloat = 0
    @State var isFaceUp = false
    @Binding var isFaceUpForAll: Bool
    @Binding var textGameStart: Bool
    @State var textGame = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.gray)
                .shadow(color: .black, radius: 4, x: 5, y: -5)
            VStack {
                if textGameStart {
                    Text(isFaceUpForAll ? card.translatedWord : card.word)
                    TextField("Введите перевод", text: $textGame)
                        .padding(.horizontal, 60)
                        .font(.title2)
                } else {
                    if isFaceUp {
                        Text(isFaceUpForAll ? card.translatedWord : card.word)
                    } else {
                        Text(isFaceUpForAll ? card.word : card.translatedWord)
                    }
                }
            }
        }
        .frame(width: 300, height: 250, alignment: .center)
        .font(.title)
        .onTapGesture {
            isFaceUp.toggle()
        }
        .offset(x: offsetCard)
        .rotationEffect(.init(degrees: offsetCard == 0 ? 0 : (offsetCard > 0 ? 10: -10)))
        .gesture(DragGesture()
                .onChanged({ value in
            withAnimation(.default) {
                offsetCard = value.translation.width
                    }})
                .onEnded({ value in
            withAnimation(Animation.easeIn) {
                if CGFloat(offsetCard) > 150 {
                    offsetCard = 500
                    card.matchUpScore -= 1
                    viewModel.changeCard(card: card)
                    print(card)
                     
                } else if CGFloat(offsetCard) < -150 {
                    offsetCard = -500
                    card.matchUpScore += 1
                    viewModel.changeCard(card: card)
                    print(card)
                   
                } else  {
                    offsetCard = 0
                }
            }}))
    }
}



