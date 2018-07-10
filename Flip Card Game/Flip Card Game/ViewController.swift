//
//  ViewController.swift
//  Flip Card Game
//
//  Created by Atacan on 8.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //The MODEL
    private lazy var game: FlipCardGame = FlipCardGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //This is a read-only computed property. It is stored only when it's used.
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0{
        didSet{ // This is a property observer
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not  in cardbuttons")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["👻", "🎃", "🦇", "💩", "🦋", "🐠", "🍄", "🐞"]
    
    private var emoji = Dictionary<Int, String>()
    //var emoji = [Int:String]()    another representation
    
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
        
        //another representation
        /*if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        } else {
            return "?"
 
        }*/
    }
}

