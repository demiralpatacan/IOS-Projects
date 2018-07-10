//
//  Card.swift
//  Flip Card Game
//
//  Created by Atacan on 8.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import Foundation

//struct is value type, meaning it gets copied! (copied when modified)
struct Card{
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // This is an initializer
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
