//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Manson Jones on 10/22/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
