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
    @State var animationTrue = false
    @Binding var isFaceUpForAll: Bool
    @Binding var textGameStart: Bool
    @State var textGame = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .shadow(color: .gray, radius: 4, x: 5, y: -5)

            ZStack {
                withAnimation(.linear(duration: 0.3)){
                    (offsetCard != 0 ? (offsetCard > 0 ? Color("red") : Color("green")) : Color.white)
                }
                if textGameStart {
                    withAnimation(.linear(duration: 1)){
                        (animationTrue ? (wordsIsEqual() ? Color("green") : Color("red")) : Color.white)
                    }
                   
                }
            }
            .cornerRadius(10)
            
            VStack {
                if textGameStart {
                    if animationTrue {
                        Text(isFaceUpForAll ? card.translatedWord : card.word)
                            .font(.largeTitle)
                            .bold()
                        
                    } else {
                        Text(isFaceUpForAll ? card.word : card.translatedWord)
                    }
                        HStack {
                            TextField("Введите перевод", text: $textGame)
                            .font(.title2)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            Button(action: {
                                animationTrue.toggle()
                                withAnimation(.linear(duration: 0.5).delay(1.5)){
                                    if wordsIsEqual() {
                                        offsetCard = -500
                                        viewModel.updateScore(card: card, offset: offsetCard)
                                    } else {
                                        offsetCard = 500
                                        viewModel.updateScore(card: card, offset: offsetCard)
                                    }
                                }
                            }) {
                                Image(systemName: "checkmark.rectangle")
                                    .foregroundColor(.purple)
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
        .foregroundColor(.black)
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
                    viewModel.updateScore(card: card, offset: offsetCard)
                    print(card)
                     
                } else if CGFloat(offsetCard) < -150 {
                    offsetCard = -500
                    viewModel.updateScore(card: card, offset: offsetCard)
                    print(card)
                   
                } else  {
                    offsetCard = 0
                }
            }}))
    }
    func wordsIsEqual() -> Bool {
        let playerText = textGame
            .lowercased()
            .deletingPrefix("a")
            .deletingPrefix("an")
            .filter {!$0.isWhitespace}
        let trueWord = (isFaceUpForAll ? card.translatedWord
                            .lowercased()
                            .deletingPrefix("a")
                            .deletingPrefix("an")
                            .deletingPrefix("to")
                        : card.word
                            .lowercased()
                            .deletingPrefix("a")
                            .deletingPrefix("to")
                            .deletingPrefix("an"))
        
        if playerText == trueWord {
            return true
        }
        return false
    }
}



