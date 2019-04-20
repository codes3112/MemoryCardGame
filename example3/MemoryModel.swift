//
//  MemoryModel.swift
//  example3
//
//  Created by sneha arora on 2018-08-23.
//  Copyright © 2018 sneha arora. All rights reserved.
//

import Foundation
//struct is used as they are copy on write semantics..i.e they get copied only when the value is changed
struct MemoryModel{
    
    private(set) var cards = [Card]()
    //making indexOfOneAndOnlyFaceUpCard a property
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            let faceUpCardIndices = cards.indices.filter{ cards[$0].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first :nil

            
//if we want to use extension Collection we can use just one line :return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
//if filter is not used the following code is used
//          var foundIndex:Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp {
//                    if foundIndex == nil{
//                        foundIndex = index
//                    } else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    //we need mutating func because var indexOfOneAndOnlyFaceUpCard is being set (mutated)
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"MemoryModel.chooseCard(at:\(index)):chosen index not in use")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            } else {
                
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards>0,"MemoryModel.init(\(numberOfPairsOfCards)):you must have atleast one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //    TODO: Shuffle the cards
    }
    
}


extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first:nil
    }
}
