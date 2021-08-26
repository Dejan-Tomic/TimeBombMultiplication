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
var difficultyUserDefault = UserDefaults.standard
var durationUserDefault = UserDefaults.standard

var player: AVAudioPlayer?
var timer = Timer()

var timerDuration = durationUserDefault.integer(forKey: "durationUserDefault")
var timeLeft = timerDuration
var chosenDifficulty = "easy"


var userAnswer = 0
var firstNumber = 0
var secondNumber = 0
var correctAnswer = 0
var score = 0
var selectedDifficulty = difficultyUserDefault.integer(forKey: "difficultyUserDefault")
var selectedDuration = durationUserDefault.integer(forKey: "selectedDurationUserDefault")

var currentHighScore = highScoreUserDefault.integer(forKey: "currentHighScore")
var currentUserDefaultKey = ""

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


func updateHighScore(currentHighScore: Int, userDefaultKey: String) {

    if score > currentHighScore {

        highScoreUserDefault.set(score, forKey: "\(userDefaultKey)")
        //    printHighScores()
    } else {
        print("Sorry not a highscore!")
    }
    //    printHighScores()
}


func resetHighScore() {
    
    switch (timerDuration, chosenDifficulty) {
    
        case (60, "easy") : highScoreUserDefault.set(0, forKey: "oneMinuteEasyHighScoreUserDefault")
        case (120, "easy"): highScoreUserDefault.set(0, forKey: "twoMinutesEasyHighScoreUserDefault")
        case (300, "easy"): highScoreUserDefault.set(0, forKey: "fiveMinutesEasyHighScoreUserDefault")
        case (600, "easy"): highScoreUserDefault.set(0, forKey: "tenMinutesEasyHighScoreUserDefault")
        
        case (60, "medium"): highScoreUserDefault.set(0, forKey: "oneMinuteMediumHighScoreUserDefault")
        case (120, "medium"): highScoreUserDefault.set(0, forKey: "twoMinutesMediumHighScoreUserDefault")
        case (300, "medium"): highScoreUserDefault.set(0, forKey: "fiveMinutesMediumHighScoreUserDefault")
        case (600, "medium"): highScoreUserDefault.set(0, forKey: "tenMinutesMediumHighScoreUserDefault")

        case (60, "hard"): highScoreUserDefault.set(0, forKey: "oneMinuteHardHighScoreUserDefault")
        case (120, "hard"): highScoreUserDefault.set(0, forKey: "twoMinutesHardHighScoreUserDefault")
        case (300, "hard"): highScoreUserDefault.set(0, forKey: "fiveMinutesHardHighScoreUserDefault")
        case (600, "hard"): highScoreUserDefault.set(0, forKey: "tenMinutesHardHighScoreUserDefault")

        case (60, "expert"): highScoreUserDefault.set(0, forKey: "oneMinuteExpertHighScoreUserDefault")
        case (120, "expert"): highScoreUserDefault.set(0, forKey: "twoMinutesExpertHighScoreUserDefault")
        case (300, "expert"): highScoreUserDefault.set(0, forKey: "fiveMinutesExpertHighScoreUserDefault")
        case (600, "expert"): highScoreUserDefault.set(0, forKey: "tenMinutesExpertHighScoreUserDefault")

        default: print("Error in game settings switch")
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
//    printHighScores()

}



func calculateAnswer() {
    correctAnswer = firstNumber * secondNumber
    print("\(firstNumber) x \(secondNumber) = \(correctAnswer)")
}


func nextQuestion(difficulty: String) {

    switch difficulty {
    case "easy":
        firstNumber = [2,5,10].randomElement()!
        
    case "medium":
        firstNumber = [3,4,8].randomElement()!
        
    case "hard":
        firstNumber = Int.random(in: 1...12)

    default:
        // difficulty: "expert"
        firstNumber = Int.random(in: 12...99)
    }
    secondNumber = Int.random(in: 1...12)

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


func play(sound: String) {
    
    let path = Bundle.main.path(forResource: "\(sound).mp3", ofType: nil)!
    
    let url = URL(fileURLWithPath: path)
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
        
    } catch {
        // couldn't load file
        print("Problem during playback")
    }
}

func printHighScores() {
    
    print("1 minute easy score is \(oneMinuteEasyHighScore)")
    print("1 minute medium score is \(oneMinuteMediumHighScore)")
    print("1 minute hard score is \(oneMinuteHardHighScore)")
    print("1 minute expert score is \(oneMinuteExpertHighScore)")

    print("2 minutes easy score is \(twoMinutesEasyHighScore)")
    print("2 minutes medium score is \(twoMinutesMediumHighScore)")
    print("2 minutes hard score is \(twoMinutesHardHighScore)")
    print("2 minutes expert score is \(twoMinuteExpertHighScore)")
    
    print("5 minutes easy score is \(fiveMinutesEasyHighScore)")
    print("5 minutes medium score is \(fiveMinutesMediumHighScore)")
    print("5 minutes hard score is \(fiveMinutesHardHighScore)")
    print("5 minutes expert score is \(fiveMinuteExpertHighScore)")
      
    print("10 minutes easy score is \(tenMinutesEasyHighScore)")
    print("10 minutes medium score is \(tenMinutesMediumHighScore)")
    print("10 minutes hard score is \(tenMinutesHardHighScore)")
    print("10 minutes expert score is \(tenMinuteExpertHighScore)")
}
