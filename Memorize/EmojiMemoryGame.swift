//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manson Jones on 10/22/20.
//

// This is the ViewModel
// The ViewModel is always a class.

import Foundation

class EmojiMemoryGame : ObservableObject {
    
    // This is a reference to the model.
    // It might be better to call this game, or simulation
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in 
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
