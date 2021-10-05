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

