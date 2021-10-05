//
//  Model.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI


struct Card: Identifiable {
    var id = UUID()
    var word: String
    var translatedWord: String
    var offset: CGFloat = 0
    var matchUpScore: Int = 0
    var isFaceUp: Bool = false
    
    
    
    func updateCompletion() -> Card {
        return Card(word: word, translatedWord: translatedWord)
    }
}
