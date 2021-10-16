//
//  NewCardView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct NewCard : View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isNewCard: Bool
    @State var card: Card
    @Binding var isChanged: Bool
    @State var newWord: String = ""
    @State var newTranslatedWord: String = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(Color("backGroundColor"))
                .shadow(color: .black, radius: 4, x: 3, y: -5)
            VStack(spacing: 20) {
                Text(isNewCard ? "Новое слово" : "Изменить")
                    .bold()
                    .font(.title)
                    .padding(.vertical, 30)
                ZStack {
                    TextField("на русском" , text: isNewCard ? $newWord : $card.word)
                        .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .opacity(0.5)
                }
                .frame(width: 200, height: 40, alignment: .center)
                ZStack {
                    TextField("на английском", text: isNewCard ? $newTranslatedWord : $card.translatedWord)
                        .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .opacity(0.5)
                }
                .frame(width: 200, height: 40, alignment: .center)
                Button("Save") {
                    if isNewCard {
                        viewModel.addCard(word: newWord, translatedWord: newTranslatedWord, matchUpScore: card.matchUpScore)
                       // viewModel.gameStart()
                        isNewCard.toggle()
                    }
                    if isChanged {
                        viewModel.changeCard(card: card)
                      //  viewModel.gameStart()
                        isChanged.toggle()
                    }
                }
                Spacer()
            }
            if isChanged {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.deleteItem(card: card)
                            isChanged.toggle()
                        //    viewModel.gameStart()
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()
                }
            }
        }
        .frame(width: 325, height: 325)
    }
}


