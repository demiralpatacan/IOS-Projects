//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Atacan on 14.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var description: String { return "\(suit) \(rank)" }
    
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible    //create with raw values
    {
        var description: String { return rawValue }
        
        case spades = "♣️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♠️"
        
        static var all = [Suit.spades, .hearts, .clubs, .diamonds] 
    }
    
    enum Rank : CustomStringConvertible {
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .face(let kind): return kind
            case .numeric(let pips): return String(pips)
            }
        }
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J" : return 11
            case .face(let kind) where kind == "Q" : return 12
            case .face(let kind) where kind == "K" : return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]       //First, add ace
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), Rank.face("Q"), Rank.face("K")]
            return allRanks
        }
    }
}
