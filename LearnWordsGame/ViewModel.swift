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
    @Published var cards: [Card] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    init() {
        getItems()
        gameStart()
    }
    func saveCards() {
        self.cards = cardsGame
        objectWillChange.send()
    }
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Card].self, from: data)
        else {return}
        self.cards = savedItems
    }
    func gameStart() {
        self.cardsGame = cards
    }
    func addCard(word: String, translatedWord: String, matchUpScore: Int) {
        cards.append(Card(word: word, translatedWord: translatedWord, matchUpScore: matchUpScore))
        saveItems()
    }
    func changeCard(card: Card) {
        if let index = cards.firstIndex(where: {$0.id == card.id}) {
            cards[index] = card.updateCompletion()
        }
        saveItems()
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
    
}
