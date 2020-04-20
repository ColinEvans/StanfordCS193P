//
//  Card.swift
//  ConcentrationA1
//
//  Created by Colin Evans on 2020-04-19.
//  Copyright © 2020 Colin Evans. All rights reserved.
//

import Foundation

/// A card represents a single unit in the `Concentration` game
/// Struct is value type, no inheritence
struct Card {
    var isFacedUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0
 
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

extension Card: Equatable {
    static func ==(cardOne: Card, cardTwo: Card) -> Bool {
        return cardOne.identifier == cardTwo.identifier
    }
}
