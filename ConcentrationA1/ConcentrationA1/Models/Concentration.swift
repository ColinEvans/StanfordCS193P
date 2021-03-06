//
//  Concentration.swift
//  ConcentrationA1
//
//  Created by Colin Evans on 2020-04-19.
//  Copyright © 2020 Colin Evans. All rights reserved.
//

import Foundation

/// The main logic behind the game
class Concentration {
    // MARK: - Public variables
    var cards = [Card]()
    var score = 0
    var flips = 0
    
    // MARK: - Private Vars
    private var scoreTimer: Date
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var flippedIndex: Int?
            for (index, card) in cards.enumerated() {
                if card.isFacedUp {
                    if flippedIndex == nil {
                        flippedIndex = index
                    } else {
                        flippedIndex = nil
                        break
                    }
                }
            }
            return flippedIndex
        }

        set {
            if let index = newValue {
                for index in cards.indices {
                    cards[index].isFacedUp = false
                }
                cards[index].isFacedUp = true
            }
        }
    }
    
    // MARK: - Private variables
    private var seenCards = [Card]()

    // MARK: - Lifecycle functions
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            // Array (Struct) makes a copy when appending - not a pointer to the data
            cards += [card, card]
        }
        scoreTimer = Date(timeIntervalSinceNow: 0.0)
        cards = shuffleCards()
    }

    // MARK: - Public functions
    func chooseCard(at index: Int) {
        flips += 1
        if !cards[index].isMatched {
            // one card is face up - check if match
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,
                matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score +=  turnTimeIntoScore()
                } else {
                    checkScore(for: [index, matchIndex])
                }
                cards[index].isFacedUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    /// Halts the current progress and restarts the game with
    /// New card positions, score and flips
    func restart() {
        for index in cards.indices {
            cards[index].isFacedUp = false
            cards[index].isMatched = false
            cards[index].hasBeenSeen = false
        }
        cards = shuffleCards()
        score = 0
        flips = 0
    }

    // MARK: - Private Functions
    /// Shuffles the indicies of the `cards` such that no two identifiers are adjacent to each other
    private func shuffleCards() -> [Card] {
        var shuffledDeck = [Card]()
        for _ in cards.indices {
            let randomIndex = arc4random_uniform(UInt32(cards.count))
            let randomCard = cards.remove(at: Int(randomIndex))
            shuffledDeck.append(randomCard)
        }
        return shuffledDeck
    }

    private func checkScore(for indecies: [Int]){
        for index in indecies {
            if !cards[index].hasBeenSeen {
                cards[index].hasBeenSeen = true
            } else {
                score -= 1
            }
        }
    }
    
    private func turnTimeIntoScore() -> Int {
        let checkTimeDate = Date(timeIntervalSinceNow: 0.0)
        let matchTime = checkTimeDate.timeIntervalSince(scoreTimer)
        scoreTimer = checkTimeDate

        if matchTime > 10 {
            return 1
        }

        if matchTime > 5 {
            return 2
        }

        return 4
    }
}
