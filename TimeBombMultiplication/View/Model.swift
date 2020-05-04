//
//  Functions.swift
//  TimeBombMultiplication
//
//  Created by Dejan Tomic on 03/05/2020.
//  Copyright © 2020 Dejan Tomic. All rights reserved.
//

import Foundation
var highScoreUserDefault = UserDefaults.standard

var chosenDifficulty = "easy"

func setHighScore() {
    if score > highscore {
        highScoreUserDefault.set(score, forKey: "highScoreUserDefault")
    }
}

func calculateAnswer() {
    correctAnswer = firstNumber * secondNumber
    print("\(firstNumber) x \(secondNumber) = \(correctAnswer)")
}


func nextQuestion(difficulty: String) {
    switch difficulty {
    case "easy":
        firstNumber = Int.random(in: 1...12)
        secondNumber = Int.random(in: 1...12)
        
    case "medium":
        firstNumber = Int.random(in: 1...12)
        secondNumber = Int.random(in: 13...99)
        
    case "hard":
        firstNumber = Int.random(in: 13...99)
        secondNumber = Int.random(in: 13...99)
        
    case "expert":
        firstNumber = Int.random(in: 100...999)
        secondNumber = Int.random(in: 11...99)
        
    default:
        firstNumber = Int.random(in: 1...12)
        secondNumber = Int.random(in: 1...12)
    }
    
}

