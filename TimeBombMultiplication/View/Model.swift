//
//  Functions.swift
//  TimeBombMultiplication
//
//  Created by Dejan Tomic on 03/05/2020.
//  Copyright © 2020 Dejan Tomic. All rights reserved.
//

import Foundation
import AVFoundation

var highScoreUserDefault = UserDefaults.standard
var chosenDifficulty = "easy"
var player: AVAudioPlayer?
var timer = Timer()

var seconds = 0
var timerDuration = 60
var userAnswer = 0
var firstNumber = 0
var secondNumber = 0
var correctAnswer = 0
var score = 0
var selectedDifficulty = 0

var highscore = highScoreUserDefault.integer(forKey: "highScoreUserDefault")



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


func play(sound: String) {
    let path = Bundle.main.path(forResource: "\(sound).mp3", ofType: nil)!
    let url = URL(fileURLWithPath: path)
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
        
    } catch {
        // couldn't load file :(
        print("Problem during playback")
    }
}
