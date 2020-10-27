//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Manson Jones on 10/22/20.
//

import SwiftUI

// A ContentView functions like a View
// This is not object oriented programming

struct EmojiMemoryGameView: View {
    // Note that because the viewModel is a class,
    // that the following creates a pointer to the EmojiMemoryGame
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card:card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
        // .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    // A ViewBuilder is a list of views
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
        ZStack {
            Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(110-90), clockwise: true)
                .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
        // .modifier(Cardify(isFaceUp: card.isFaceUp))
        .cardify(isFaceUp: card.isFaceUp)
        }
    }
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.7
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
