//
//  GameThemes.swift
//  ConcentrationA1
//
//  Created by Colin Evans on 2020-04-25.
//  Copyright © 2020 Colin Evans. All rights reserved.
//

import Foundation

/// Each theme for the game
/// Static `Enum` are preferred as you cannot accidently create a uses value type that does nothing (vs `Struct`)
/// Works as a pure namespace
enum GameThemes {

    /// Themes for the emojis on the card
    enum EmojiThemes {
        static let halloweenTheme = ["🎃", "👻","💀", "🙀", "🌚", "🦿", "🧟‍♀️", "🧛🏻‍♀️", "🧙‍♂️"]
        static let xmasTheme = ["☃️", "🧣","🎅🏻", "🤶🏼", "❄️", "🎁", "🍪", "🥛", "🎄"]
        static let beachTheme = ["☀️", "🏖","⛱", "🤽‍♂️", "🏊‍♂️", "🏄", "🌞", "🤙", "🤿"]
        static let petTheme =  ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐼", "🐨", "🐯"]
        static let schoolTheme = ["📝", "✏️", "📚", "📏", "📖", "💻", "🥡", "🍻", "💸"]
        static let faceTheme = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "☺️", "🤣"]
    }
    
    /// Colors representing the background and flipped card color
    enum ThemeColors {
        static let halloweenTheme = GameColors(
            backgroundColor: .black,
            cardFlipColor: .systemOrange
        )
        static let xmasTheme = GameColors(
            backgroundColor: .systemTeal,
            cardFlipColor: .white
        )
        static let beachTheme = GameColors(
            backgroundColor: .systemYellow,
            cardFlipColor: .blue
        )
        static let petTheme = GameColors(
            backgroundColor: .black,
            cardFlipColor: .white
        )
        static let schoolTheme = GameColors(
            backgroundColor: .black,
            cardFlipColor: .yellow
        )
        static let faceTheme = GameColors(
            backgroundColor: .green,
            cardFlipColor: .purple
        )
        
    }
    
    static let themes =
    [
        (emojis: EmojiThemes.halloweenTheme, Colors: ThemeColors.halloweenTheme),
        (emojis: EmojiThemes.xmasTheme, Colors: ThemeColors.xmasTheme),
        (emojis: EmojiThemes.beachTheme, Colors: ThemeColors.beachTheme),
        (emojis: EmojiThemes.petTheme, Colors: ThemeColors.petTheme),
        (emojis: EmojiThemes.schoolTheme, Colors: ThemeColors.schoolTheme),
        (emojis: EmojiThemes.faceTheme, Colors: ThemeColors.faceTheme),
    ]
}
