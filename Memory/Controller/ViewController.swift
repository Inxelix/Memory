//
//  ViewController.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 29/03/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Memory!
    
    let emojiList = ["🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐵", "🦉", "🦇", "🐝", "🦄", "🐷", "🐣", "🐳", "🦋"]
    var emojiForCards: [String]!
    var emoji = [Int:String]()
    
    let alert = UIAlertController(title: "U rock!", message: "Do you want to restart game?", preferredStyle: .alert)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAlertAction()
        newGame()
    }
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex, cardButtons)
            updateButtons()
        }
    }
    
    func createAlertAction() {
        
        let action = UIAlertAction(title: "Restart", style: .default) { (action) in
            
            self.newGame()
            
        }
        
        alert.addAction(action)
    }
    
    func updateButtons() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                showCard(button, card)
                if card.isMatched {
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
        
        endOfGame()
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiForCards.count > 0 {
            let randomIndex = Int.random(in: 0 ..< emojiForCards.count)
            emoji[card.id] = emojiForCards.remove(at: randomIndex)
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
        newGame()
    }
    
    func newGame() {
        emojiForCards = emojiList
        game = Memory(numberOfPairsOfCrads: (cardButtons.count + 1) / 2)
        updateButtons()
    }

    func endOfGame() {
        if game.allCardsHaveBeenMatched {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
                self.present(self.alert, animated: true, completion: nil)
            }
        }
    }
    
}
