//
//  ContentView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isNewCard = false
    var columns: [GridItem] =
            Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 15) {
                        ForEach(viewModel.cards.reversed()) { card in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.gray)
                                    .shadow(color: .gray, radius: 1, x: 1, y: -1)
                                VStack {
                                    Text(card.word)
                                        .padding(3)
                                    Text(card.translatedWord)
                                        .padding(3)
                                }
                            }
                        }
                    }
                }
                .blur(radius: isNewCard  ? 6 : 0)
                .opacity(isNewCard ? 0.6 : 1)
                if isNewCard {
                 NewCard(isNewCard: $isNewCard)
                }
            }
            .toolbar {
                Button(action: {
                    isNewCard.toggle()
                },
                       label: {
                    Image(systemName: "plus")
                })
                    }
            .navigationTitle("Коллекция карточек")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

struct NewCard : View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isNewCard: Bool
    @State var newWord: String = ""
    @State var newTranslatedWord: String = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
                .shadow(color: .black, radius: 4, x: 3, y: -5)
            VStack(spacing: 20) {
                Text("Новое слово")
                    .bold()
                    .font(.title)
                    .padding(.vertical, 30)
                ZStack {
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
                    viewModel.addCard(word: newWord, translatedWord: newTranslatedWord)
                    isNewCard.toggle()
                }
                Spacer()
            }
        }
        .frame(width: 300, height: 300)
    }
}
