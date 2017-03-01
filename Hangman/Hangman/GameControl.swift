//
//  GameControl.swift
//  Hangman
//
//  Created by Pransu Dash on 2/26/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class GameControl {
    
    var phrase: String
    var manState: Int
    var dead: Int = 7
    var blankState: String = ""
    var guesses: String = ""
    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init(phrase: String) {
        self.phrase = phrase
        self.manState = 1
    }
    
    func getBlank() -> String {
        var blanks = ""
        for c in self.phrase.characters {
            if c == " " {
                blanks += "  "
            } else {
                blanks += "_ "
            }
        }
        self.blankState = blanks;
        return blanks
    }
    
    func getManState(guess: Character) -> Int {
        if self.phrase.characters.contains(guess) {
            updateBlankState(guess: guess)
            return manState
        } else if manState + 1 == dead {
            return -1
        } else {
            if (!self.guesses.contains(String(guess))) {
                if self.guesses.characters.count == 0 {
                    self.guesses += String(guess)
                } else {
                    self.guesses += ", " + String(guess)
                }
                manState += 1
            }
            return manState
        }
    }
    
    func updateBlankState(guess: Character) {
        var i: Int = 0;
        for c in self.phrase.characters {
            if guess == c {
                let index = self.blankState.index(self.blankState.startIndex, offsetBy: i * 2)
                self.blankState.remove(at: index)
                self.blankState.insert(c, at: index)
            }
            i += 1
        }
    }
    
    func getBlankState() -> String {
        return self.blankState
    }
    
    func getGuesses() -> String {
        return self.guesses
    }
    
}

