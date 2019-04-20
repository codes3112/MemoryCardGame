//
//  ViewController.swift
//  example3
//
//  Created by sneha arora on 2018-08-17.
//  Copyright © 2018 sneha arora. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    private lazy var game = MemoryModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //making numberOfPairsOfcrads a get property
    
    var numberOfPairsOfCards :Int{
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes:[NSAttributedStringKey:Any]=[
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips:\(flipCount)",attributes:attributes)
        flipCountLabel.attributedText = attributedString
        // flipCountLabel.text = "Flips: \(flipCount)"
        
    }
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print(cardNumber)
            if cardButtons.count == 2 {
                UIView.animate(withDuration: 1.2, delay: 0.2, options: .curveEaseOut, animations:{
                    self.cardButtons[cardNumber].alpha = 0.0
                })
            }
            
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        if cardButtons != nil {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
          }
       }
    
    var theme:String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]  //empty dictionary
            updateViewFromModel()
        }
    }
    //var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]  //array
    var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            
            //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card.identifier] = String(emojiChoices.remove(at: stringIndex))
            //emoji[card.identifier] = emojiChoices.remove(at:emojiChoices.count.arc4random) //used for array
        }
        return emoji[card.identifier] ?? "?"
    }
}
    extension Int {
        var arc4random: Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            } else if self<0 {
                return  -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
            }
            
        }
    }


    
    /*func flipCard(withEmoji emoji:String, on button:UIButton){
        
        if button.currentTitle == emoji
        {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor =  #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        }else
        {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }

    

    } */




