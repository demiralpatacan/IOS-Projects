//
//  ViewController.swift
//  PlayingCard
//
//  Created by Atacan on 14.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

