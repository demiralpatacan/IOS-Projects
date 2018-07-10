//
//  FlipCardGame.swift
//  Flip Card Game
//
//  Created by Atacan on 8.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import Foundation

class FlipCardGame {
    
    private(set) var cards = [Card]()
    
    //It is optional property because it can be either int or nil
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        //The following line is an assertion to protect the API
        assert(cards.indices.contains(index), "FlipCardGame.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "FlipCardGame.init(\(numberOfPairsOfCards)): You must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)  //matching card
            //cards += [card, card]
        }
        //TODO: Suffle the cards
    }
}
