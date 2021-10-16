//
//  ViewModel.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var score : Int = 0
    @Published var cardsGame: [Card] = []
    @Published var mistakesCards: [Card] = []
     var cards: [Card] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    init() {
        getItems()
        gameStart()
    }

    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Card].self, from: data)
        else {return}
        self.cards = savedItems
    }
    func gameStart() {
        mistakesCards = mistakesArray()
        
        self.cardsGame = (mistakesCards + cards).shuffled()
        print(cards)
        
     
    }
    func addCard(word: String, translatedWord: String, matchUpScore: Int) {
        cards.append(Card(word: word, translatedWord: translatedWord, matchUpScore: matchUpScore))
        
    }
    func changeCard(card: Card) {
        if let index = cards.firstIndex(where: {$0.id == card.id}) {
            print(card.matchUpScore)
            cards[index] = card.updateCompletion()
        }
    }
    func updateScore(card: Card, offset: CGFloat) {
        if let index = cards.firstIndex(where: {$0.word == card.word}) {
            print(card.matchUpScore)
            if  offset > 0 {
                cards[index].matchUpScore -= 1
                cards[index] = cards[index].updateCompletion()
                print(card.matchUpScore)
            } else if offset < 0 {
                cards[index].matchUpScore += 1
                cards[index] = cards[index].updateCompletion()
                print(card.matchUpScore)
            }
        }
    }
    
    func deleteItem(card: Card) {
        if let index = cards.firstIndex(where: {$0.id == card.id}) {
            cards.remove(at: index)
        }
    }
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    func mistakesArray() -> [Card] {
        let mistake = cards.filter {$0.matchUpScore < 0}
        for card in mistake {
            mistakesCards.append(Card(word: card.word, translatedWord: card.translatedWord, matchUpScore: card.matchUpScore))
        }
        
        return mistakesCards
    }
}
