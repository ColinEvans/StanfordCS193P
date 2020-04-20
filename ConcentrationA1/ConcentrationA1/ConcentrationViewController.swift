//
//  ViewController.swift
//  ConcentrationA1
//
//  Created by Colin Evans on 2020-04-19.
//  Copyright © 2020 Colin Evans. All rights reserved.
//

import UIKit

/// Each theme for the game
/// Static `Enum` are preferred as you cannot accidently create a uses value type that does nothing (vs `Struct`)
/// Works as a pure namespace
enum GameThemes {
    static let Halloween = ["🎃", "👻","💀", "🙀", "🌚", "🦿", "🧟‍♀️", "🧛🏻‍♀️", "🧙‍♂️"]
    static let Xmas = ["☃️", "🧣","🎅🏻", "🤶🏼", "❄️", "🎁", "🍪", "🥛", "🎄"]
    static let beach = ["☀️", "🏖","⛱", "🤽‍♂️", "🏊‍♂️", "🏄", "🌞", "🤙", "🤿"]
    static let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐼", "🐨", "🐯"]
    static let school = ["📝", "✏️", "📚", "📏", "📖", "💻", "🥡", "🍻", "💸"]
    static let happyFace = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "☺️", "🤣"]
}


/// View controller managing the UI for the gameboard
class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var cardButtonViews: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Class Variables
    /// doesn't initalize the value until it's called
    var game: Concentration!
    private var emojiChoices = ViewController.themes.randomElement() ?? GameThemes.Halloween
    private var emoji = [Int: String]()
    
    // Possible themes loaded into the game
    private static let themes = [
        GameThemes.Halloween,
        GameThemes.Xmas,
        GameThemes.beach,
        GameThemes.animals,
        GameThemes.school,
        GameThemes.happyFace
    ]

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        game = Concentration(numberOfPairsOfCards: ((cardButtonViews.count + 1) / 2))
    }
    
    // MARK: - Methods
    /// Action to trigger when a user has touched a card in the UI
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtonViews.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
  
    /// Action that halts the current progress and restarts the game
    @IBAction func restartGame(_ sender: Any) {
        game.restart()
        emojiChoices = ViewController.themes.randomElement() ?? GameThemes.Halloween
        emoji.removeAll()
        updateViewFromModel()
    }

    // MARK: - Private methods
    private func updateViewFromModel() {
        for index in cardButtonViews.indices {
            let button = cardButtonViews[index]
            let card = game.cards[index]

            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flips)"
        scoreLabel.text = "Score: \(game.score)"
    }

    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil,
        emojiChoices.count > 0 {
            let randomIndex = arc4random_uniform(UInt32(emojiChoices.count))
            let randomEmoji = emojiChoices.remove(at: Int(randomIndex))
            emoji[card.identifier] = randomEmoji
        }
        return emoji[card.identifier] ?? "?"
    }
    
}
