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
  //  @State var card: Card
 // ?   @Binding var isChanged: Bool
    @State var newWord: String = ""
    @State var newTranslatedWord: String = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
                .shadow(color: .black, radius: 4, x: 3, y: -5)
            VStack(spacing: 20) {
                Text(isNewCard ? "Новое слово" : "Изменить")
                    .bold()
                    .font(.title)
                    .padding(.vertical, 30)
                ZStack {
             //       TextField(isNewCard ? "на русском" : card.word , text: $newWord)
                    TextField("на русском", text: $newWord)
                        .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .opacity(0.5)
                }
                .frame(width: 200, height: 40, alignment: .center)
                ZStack {
                    TextField("на английском", text: $newTranslatedWord)
                        .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .opacity(0.5)
                }
                .frame(width: 200, height: 40, alignment: .center)
                Button("Save") {
                    if isNewCard {
                        viewModel.addCard(word: newWord, translatedWord: newTranslatedWord)
                        isNewCard.toggle()
                    }
                }
                Spacer()
            }
        }
        .frame(width: 300, height: 300)
    }
}
