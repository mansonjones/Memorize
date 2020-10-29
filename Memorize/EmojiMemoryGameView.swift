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
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: animationDelay)) {
                        viewModel.choose(card:card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
    }
    
    private let animationDelay: Double = 0.75
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // A ViewBuilder is a list of views
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining*360 - 90), clockwise:  true)
                    }
                }.padding(5).opacity(0.4)
                .transition(.scale)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    // MARK: - Drawing Constants
    
    // private let cornerRadius: CGFloat = 10.0
    // private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.7
    private let cardSpinAngle: Double = 360.0
    
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
