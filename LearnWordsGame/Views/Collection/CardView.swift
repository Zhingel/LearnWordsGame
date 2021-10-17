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
                .shadow(color: .gray, radius: 4, x: 5, y: -5)
            VStack {
                Text(card.word)
                    .padding(3)
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .opacity(0.75)
                Text(card.translatedWord)
                    .padding(3)
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .opacity(0.75)
            //    Text("\(card.matchUpScore)")
                switch card.matchUpScore {
                case ...(-3) :
                    Text("🙈")
                        .font(.title)
                case (-2)...0 :
                    Text("⭐️")
                        .font(.title)
                case 1...4 :
                    Text("⭐️ ⭐️")
                        .font(.title)
                case 5... :
                    Text("⭐️ ⭐️ ⭐️")
                        .font(.title)
                default:
                    Text("good")
                }
            }
        }
        .foregroundColor(.black)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(word: "Яблоко", translatedWord: "Apple", matchUpScore: 0))
            .previewLayout(.sizeThatFits)
    }
}
