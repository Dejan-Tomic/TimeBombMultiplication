//
//  SettingsViewController.swift
//  TimeBombMultiplication
//
//  Created by Dejan Tomic on 03/05/2020.
//  Copyright © 2020 Dejan Tomic. All rights reserved.
//

import UIKit

var seconds = 0
var timerDuration = 60
var userAnswer = 0
var firstNumber = 0
var secondNumber = 0
var correctAnswer = 0
var score = 0
var selectedDifficulty = 0

var highscore = highScoreUserDefault.integer(forKey: "highScoreUserDefault")

class SettingsViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UISegmentedControl!
    @IBOutlet weak var durationSegementedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayHighScore()
    }
    
    func displayHighScore() {
        highScoreLabel.text = "High score: \(highscore)"
    }
    
    
    @IBAction func resetHighscore(_ sender: UIButton) {
        highscore = 0
        highScoreUserDefault.set(highscore, forKey: "highScoreUserDefault")
        highScoreLabel.text = "High score: \(highscore)"

    }
    
    
    @IBAction func durationSelected(_ sender: UISegmentedControl) {
        switch durationSegementedControl.selectedSegmentIndex {
        case 0: print("1 minute")
                timerDuration = 60
        case 1: print("2 minutes")
                timerDuration = 120
        case 2: print("5 minutes")
                timerDuration = 300
        case 3: print("10 minutes")
                timerDuration = 600
        default: print("error")
        }
        print("\(timerDuration)")

    }
    
    
    @IBAction func difficultySelected(_ sender: UISegmentedControl) {
        
        switch difficultyLabel.selectedSegmentIndex {
        case 0: chosenDifficulty = "easy"
                selectedDifficulty = 0
        case 1: chosenDifficulty = "medium"
                selectedDifficulty = 1
        case 2: chosenDifficulty = "hard"
                selectedDifficulty = 2
        case 3: chosenDifficulty = "expert"
                selectedDifficulty = 3
        default: chosenDifficulty = "easy"
        }
    }
    
    
        
}
