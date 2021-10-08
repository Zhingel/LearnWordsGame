//
//  CardView.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI

struct CardView: View {
    var card: Card
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: 150, height: 150)
                .shadow(color: .gray, radius: 1, x: 1, y: -1)
            VStack {
                Text(card.word)
                    .padding(3)
                Text(card.translatedWord)
                    .padding(3)
                Text("\(card.matchUpScore)")
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(word: "Яблоко", translatedWord: "Apple", matchUpScore: 0))
            .previewLayout(.sizeThatFits)
    }
}
