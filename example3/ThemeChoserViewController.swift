//
//  ThemeChoserViewController.swift
//  example3
//
//  Created by sneha arora on 2018-09-03.
//  Copyright © 2018 sneha arora. All rights reserved.
//

import UIKit

class ThemeChoserViewController: UIViewController {
    
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseTheme" {
            if let button = sender as? UIButton{
                if let themeName = button.currentTitle {
                    let theme = themes[themeName]
                    if let cvc = segue.destination as? ViewController {
                        cvc.theme = theme
                    }
                }
            }
        }
    }
   

}
