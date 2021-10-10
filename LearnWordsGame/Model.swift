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

///
/// Создается массив для игры он и показывает карточки, и данные в настоящем массиве перезаписываются сразу
///
///
/// не могу выставить превью для newCard
/// Массив, созданный специально для игры, постоянно перемешивается
