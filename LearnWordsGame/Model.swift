//
//  Model.swift
//  LearnWordsGame
//
//  Created by Стас Жингель on 05.10.2021.
//

import SwiftUI


struct Card: Identifiable, Codable {
    var id = UUID()
    var word: String
    var translatedWord: String
    var matchUpScore: Int = 0

    
    
    func updateCompletion() -> Card {
        return Card(word: word, translatedWord: translatedWord, matchUpScore: matchUpScore)
    }
    
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

