//
//  AllCardCollection.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct AllCardCollection: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var cardChoosen: Card = Card(word: "", translatedWord: "", matchUpScore: 0)
    @State var isChanged = false
    @State var isNewCard = false
    var columns: [GridItem] =
            Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, alignment: .center) {
                        ForEach(viewModel.cards.reversed()) { card in
                            CardView(card: card)
                                .padding(.top, 15)
                                .onTapGesture {
                                    print(card)
                                }
                                .onLongPressGesture {
                                if !isChanged {
                                    cardChoosen = card
                                    isChanged.toggle()
                                }
                            }
                        }
                    }
                }
                .allowsHitTesting(isNewCard || isChanged ? false : true)
                .blur(radius: isNewCard || isChanged  ? 6 : 0)
                .opacity(isNewCard || isChanged ? 0.6 : 1)
                if isNewCard  || isChanged {
                    NewCard(isNewCard: $isNewCard, card: cardChoosen, isChanged: $isChanged)
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
            .background(Color("backGroundColor"))
        }
    }
}

struct AllCardCollection_Previews: PreviewProvider {
    static var previews: some View {
        AllCardCollection()
            .environmentObject(ViewModel())
    }
}
