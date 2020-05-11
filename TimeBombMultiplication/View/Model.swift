//
//  Functions.swift
//  TimeBombMultiplication
//
//  Created by Dejan Tomic on 03/05/2020.
//  Copyright © 2020 Dejan Tomic. All rights reserved.
//

import Foundation
import AVFoundation

var gameSettingsUserDefault = UserDefaults.standard

var highScoreUserDefault = UserDefaults.standard
var difficultyUserDefault = UserDefaults.standard
var durationUserDefault = UserDefaults.standard

var chosenDifficulty = "easy"
var player: AVAudioPlayer?
var timer = Timer()

var seconds = 0
var timerDuration = 60
var timeLeft = timerDuration
var userAnswer = 0
var firstNumber = 0
var secondNumber = 0
var correctAnswer = 0
var score = 0
var selectedDifficulty = 0
var selectedDuration = 0

var highscore = highScoreUserDefault.integer(forKey: "highScoreUserDefault")

var oneMinuteEasyHighScore = highScoreUserDefault.integer(forKey: "oneMinuteEasyHighScoreUserDefault")
var twoMinutesEasyHighScore = highScoreUserDefault.integer(forKey: "twoMinutesEasyHighScoreUserDefault")
var fiveMinutesEasyHighScore = highScoreUserDefault.integer(forKey: "fiveMinutesEasyHighScoreUserDefault")
var tenMinutesEasyHighScore = highScoreUserDefault.integer(forKey: "tenMinutesEasyHighScoreUserDefault")

var oneMinuteMediumHighScore = highScoreUserDefault.integer(forKey: "oneMinuteMediumHighScoreUserDefault")
var twoMinutesMediumHighScore = highScoreUserDefault.integer(forKey: "twoMinutesMediumHighScoreUserDefault")
var fiveMinutesMediumHighScore = highScoreUserDefault.integer(forKey: "fiveMinutesMediumHighScoreUserDefault")
var tenMinutesMediumHighScore = highScoreUserDefault.integer(forKey: "tenMinutesMediumHighScoreUserDefault")

var oneMinuteHardHighScore = highScoreUserDefault.integer(forKey: "oneMinuteHardHighScoreUserDefault")
var twoMinutesHardHighScore = highScoreUserDefault.integer(forKey: "twoMinutesHardHighScoreUserDefault")
var fiveMinutesHardHighScore = highScoreUserDefault.integer(forKey: "fiveMinutesHardHighScoreUserDefault")
var tenMinutesHardHighScore = highScoreUserDefault.integer(forKey: "tenMinutesHardHighScoreUserDefault")

var oneMinuteExpertHighScore = highScoreUserDefault.integer(forKey: "oneMinuteExpertHighScoreUserDefault")
var twoMinuteExpertHighScore = highScoreUserDefault.integer(forKey: "twoMinutesExpertHighScoreUserDefault")
var fiveMinuteExpertHighScore = highScoreUserDefault.integer(forKey: "fiveMinutesExpertHighScoreUserDefault")
var tenMinuteExpertHighScore = highScoreUserDefault.integer(forKey: "tenMinutesExpertHighScoreUserDefault")



func setHighScore() {
    if score > highscore {
        highScoreUserDefault.set(score, forKey: "highScoreUserDefault")
    }
}

func updateHighScore(currentHighScore: Int, userDefaultKey: String) {
    if score > currentHighScore {
        highScoreUserDefault.set(score, forKey: "\(userDefaultKey)")
    }
}

func checkScoreAgainstHighScore() {
    switch (timerDuration, chosenDifficulty) {
        case (60, "easy") : updateHighScore(currentHighScore: oneMinuteEasyHighScore, userDefaultKey: "oneMinuteEasyHighScoreUserDefault")
        case (120, "easy"): updateHighScore(currentHighScore: twoMinutesEasyHighScore, userDefaultKey: "twoMinutesEasyHighScoreUserDefault")
        case (300, "easy"): updateHighScore(currentHighScore: fiveMinutesEasyHighScore, userDefaultKey: "fiveMinutesEasyHighScoreUserDefault")
        case (600, "easy"): updateHighScore(currentHighScore: tenMinutesEasyHighScore, userDefaultKey: "tenMinutesEasyHighScoreUserDefault")
        
        case (60, "medium"): updateHighScore(currentHighScore: oneMinuteMediumHighScore, userDefaultKey: "oneMinuteMediumHighScoreUserDefault")
        case (120, "medium"): updateHighScore(currentHighScore: twoMinutesMediumHighScore, userDefaultKey: "twoMinutesMediumHighScoreUserDefault")
        case (300, "medium"): updateHighScore(currentHighScore: fiveMinutesMediumHighScore, userDefaultKey: "fiveMinutesMediumHighScoreUserDefault")
        case (600, "medium"): updateHighScore(currentHighScore: tenMinutesMediumHighScore, userDefaultKey: "tenMinutesMediumHighScoreUserDefault")

        case (60, "hard"): updateHighScore(currentHighScore: oneMinuteHardHighScore, userDefaultKey: "oneMinuteHardHighScoreUserDefault")
        case (120, "hard"): updateHighScore(currentHighScore: twoMinutesHardHighScore, userDefaultKey: "twoMinutesHardHighScoreUserDefault")
        case (300, "hard"): updateHighScore(currentHighScore: fiveMinutesHardHighScore, userDefaultKey: "fiveMinutesHardHighScoreUserDefault")
        case (600, "hard"): updateHighScore(currentHighScore: tenMinutesHardHighScore, userDefaultKey: "tenMinutesHardHighScoreUserDefault")

        case (60, "expert"): updateHighScore(currentHighScore: oneMinuteExpertHighScore, userDefaultKey: "oneMinuteExpertHighScoreUserDefault")
        case (120, "expert"): updateHighScore(currentHighScore: twoMinuteExpertHighScore, userDefaultKey: "twoMinutesExpertHighScoreUserDefault")
        case (300, "expert"): updateHighScore(currentHighScore: fiveMinuteExpertHighScore, userDefaultKey: "fiveMinutesExpertHighScoreUserDefault")
        case (600, "expert"): updateHighScore(currentHighScore: tenMinuteExpertHighScore, userDefaultKey: "tenMinutesExpertHighScoreUserDefault")

        default: print("Error in game settings switch")
    }
}



func calculateAnswer() {
    correctAnswer = firstNumber * secondNumber
    print("\(firstNumber) x \(secondNumber) = \(correctAnswer)")
}


func nextQuestion(difficulty: String) {
    let easyArray = [2,5,10]
    let mediumArray = [3,4,8]

    switch difficulty {
    case "easy":
        firstNumber = easyArray.randomElement()!
        secondNumber = Int.random(in: 1...12)
        
    case "medium":
        firstNumber = mediumArray.randomElement()!
        secondNumber = Int.random(in: 1...12)
        
    case "hard":
        firstNumber = Int.random(in: 1...12)
        secondNumber = Int.random(in: 1...12)
        
    case "expert":
        firstNumber = Int.random(in: 12...99)
        secondNumber = Int.random(in: 12...99)

    default:
        firstNumber = easyArray.randomElement()!
        secondNumber = Int.random(in: 1...12)
    }
    
}


func gameSettings(timeSetting: Int, difficultySetting: String) {
    switch (timeSetting, difficultySetting) {
        case (60, "easy") : print("60 easy")
        case (120, "easy"): print("120 easy")
        case (300, "easy"): print("300 easy")
        case (600, "easy"): print("600 easy")
        
        case (60, "medium"): print("60 medium")
        case (120, "medium"): print("120 medium")
        case (300, "medium"): print("300 medium")
        case (600, "medium"): print("600 medium")

        case (60, "hard"): print("60 hard")
        case (120, "hard"): print("120 hard")
        case (300, "hard"): print("300 hard")
        case (600, "hard"): print("600 hard")

        case (60, "expert"): print("60 expert")
        case (120, "expert"): print("120 expert")
        case (300, "expert"): print("300 expert")
        case (600, "expert"): print("600 expert")

        default: print("Error in game settings switch")
    }
    
}



//func saveGameSettings(timeSetting: Int, difficultySetting: String) {
//    switch (timeSetting, difficultySetting) {
//    case (60, "easy") : gameSettingsUserDefault.set(selectedDuration, forKey: "oneMinuteEasyGame")
//    case (120, "easy"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesEasyGame")
//    case (300, "easy"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesEasyGame")
//    case (600, "easy"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesEasyGame")
//    
//    case (60, "medium"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesMediumGame")
//    case (120, "medium"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesMediumGame")
//    case (300, "medium"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesMediumGame")
//    case (600, "medium"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesMediumGame")
//        
//    case (60, "hard"):  gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesHardGame")
//    case (120, "hard"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesHardGame")
//    case (300, "hard"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesHardGame")
//    case (600, "hard"): gameSettingsUserDefault.set(selectedDuration, forKey: "MinutesHardGame")
//
//    case (60, "expert"): print("60 expert")
//    case (120, "expert"): print("120 expert")
//    case (300, "expert"): print("300 expert")
//    case (600, "expert"): print("600 expert")
//
//    default: print("Error in game settings switch")
//}
//}



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
