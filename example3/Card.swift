//
//  Card.swift
//  example3
//
//  Created by sneha arora on 2018-08-17.
//  Copyright © 2018 sneha arora. All rights reserved.
//

import Foundation

struct Card {
    
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
