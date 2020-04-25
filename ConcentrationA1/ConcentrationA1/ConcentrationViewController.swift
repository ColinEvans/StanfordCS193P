//
//  ViewController.swift
//  ConcentrationA1
//
//  Created by Colin Evans on 2020-04-19.
//  Copyright © 2020 Colin Evans. All rights reserved.
//

import UIKit

/// View controller managing the UI for the gameboard
class ConcentrationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var cardButtonViews: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yinuoLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    // MARK: - Class Variables
    var game: Concentration!
    private var emojiChoices = [String]()
    private var secondaryColor = UIColor()
    private var emoji = [Int: String]()
    private let concentrationThemes = GameThemes.themes
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        game = Concentration(numberOfPairsOfCards: ((cardButtonViews.count + 1) / 2))
        setThemes()

        /// When we load the game the color must be set to the selected theme color
        for button in cardButtonViews {
            button.backgroundColor = secondaryColor
        }
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
        setThemes()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0) : secondaryColor
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
    
    private func setThemes() {
        guard let newTheme = concentrationThemes.randomElement() else { return }
        emojiChoices = newTheme.emojis
        view.backgroundColor =  newTheme.Colors.backgroundColor
        secondaryColor = newTheme.Colors.cardFlipColor
        flipCountLabel.textColor = secondaryColor
        scoreLabel.textColor = secondaryColor
        yinuoLabel.textColor = secondaryColor
        newGameButton.setTitleColor(secondaryColor, for: .normal)
    }
}
