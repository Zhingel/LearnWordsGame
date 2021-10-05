//
//  ViewModel.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import Foundation

class ViewModel: ObservableObject {
    var cards: [Card] = [
        Card(word: "Первый", translatedWord: "First"),
        Card(word: "Второй", translatedWord: "Second"),
        Card(word: "Третий", translatedWord: "Third"),
        Card(word: "Четвертый", translatedWord: "Fourth"),
        Card(word: "Пятый", translatedWord: "Fifth"),
        Card(word: "Шестой", translatedWord: "Sixth"),
        Card(word: "Седьмой", translatedWord: "Seventh"),
        Card(word: "Восьмой", translatedWord: "Eighth"),
        Card(word: "Девятый", translatedWord: "Ninth")
    ]
    
    func addCard(word: String, translatedWord: String) {
        cards.append(Card(word: word, translatedWord: translatedWord))
    }
    func changeCard(card: Card) {
        if let index = cards.firstIndex(where: {$0.id == card.id}) {
            cards[index] = card.updateCompletion()
        }
    }
    func deleteItem(indexSet: IndexSet) {
        cards.remove(atOffsets: indexSet)
    }
}
