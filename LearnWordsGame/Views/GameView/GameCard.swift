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
                .fill(.gray)
                .shadow(color: .black, radius: 4, x: 5, y: -5)
            ZStack  {
                if offsetCard > 30 {
                    LinearGradient(colors: [.green,.gray], startPoint: .init(x: 1, y: 1), endPoint: .init(x: 1 - (offsetCard - 30)*0.4/100, y: 1 - (offsetCard - 30)*0.4/100))
                } else if offsetCard < -30 {
                    LinearGradient(colors: [.red, .gray], startPoint: .init(x: -0.9, y: 0), endPoint: .init(x: 0, y: (offsetCard + 30)/100))
                }

                
            }
            .cornerRadius(10)
            
            VStack {
                if textGameStart {
                        Text(isFaceUpForAll ? card.word : card.translatedWord)
                        HStack {
                            TextField("Введите перевод", text: $textGame)
                            .font(.title2)
                            .disableAutocorrection(true)
                            Button(action: {
                                if textGame == (isFaceUpForAll ? card.translatedWord : card.word) {
                                    offsetCard = 500
                                    card.matchUpScore += 1
                                    viewModel.changeCard(card: card)
                                    print(card)
                                } else {
                                    offsetCard = -500
                                    card.matchUpScore -= 1
                                    viewModel.changeCard(card: card)
                                    print(card)
                                }
                                    
                            }) {
                                Image(systemName: "chevron.forward.square" )
                            }
                        }
                        .padding(.horizontal, 40)
    
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
                print(offsetCard)
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



