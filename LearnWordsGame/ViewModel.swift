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
        let game = (mistakesCards + cards.filter{$0.matchUpScore < 5} + goodArray())
        
        self.cardsGame = game.shuffled()
        print(cards)
        print(game)
        
     
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
        let mistake = cards.filter {$0.matchUpScore < -3}
        for card in mistake {
            mistakesCards.append(Card(word: card.word, translatedWord: card.translatedWord, matchUpScore: card.matchUpScore))
            if cards.count > 6 {
                mistakesCards.append(Card(word: card.word, translatedWord: card.translatedWord, matchUpScore: card.matchUpScore))
            }
        }
        let mistake2 = cards.filter {$0.matchUpScore < 0 && $0.matchUpScore > -4}
        for card in mistake2 {
            mistakesCards.append(Card(word: card.word, translatedWord: card.translatedWord, matchUpScore: card.matchUpScore))
        }
        
        return mistakesCards
    }
    func goodArray() -> [Card] {
        let goodWords = cards.shuffled().filter {$0.matchUpScore > 4}
        guard goodWords.count != 0 else {return []}
        let randomElements = goodWords.count > 0 ? goodWords.count/2 : 1
        let newArray = Array(goodWords.prefix(randomElements))
        return newArray
    }
}
