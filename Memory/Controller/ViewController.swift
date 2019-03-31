//
//  ViewController.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 29/03/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Memory(numberOfPairsOfCrads: (cardButtons.count + 1) / 2)
    var emojiList = ["🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐵", "🦉", "🦇", "🐝", "🦄", "🐷", "🐣", "🐳", "🦋"]
    var emoji = [Int:String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateButtons()
        }
    }
    
    func updateButtons() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                if !card.isMatched {
                    showCard(button, card)
                } else {
                    showCard(button, card)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        button.setTitle("", for: .normal)
                        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    }
                }
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
            }
        }
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiList.count > 0 {
            let randomIndex = Int.random(in: 0 ..< emojiList.count)
            emoji[card.id] = emojiList.remove(at: randomIndex)
        }
        
        return emoji[card.id]!
    }
    
    func showCard(_ button: UIButton, _ card: Card) {
        if button.backgroundColor != #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {  // Don't show already matched cards 
            button.setTitle(emoji(for: card), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        game = Memory(numberOfPairsOfCrads: (cardButtons.count + 1) / 2)
        updateButtons()
    }

}
