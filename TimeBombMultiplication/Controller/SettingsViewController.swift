//
//  SettingsViewController.swift
//  TimeBombMultiplication
//
//  Created by Dejan Tomic on 03/05/2020.
//  Copyright © 2020 Dejan Tomic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UISegmentedControl!
    @IBOutlet weak var durationSegementedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayHighScore()
        durationSegementedControl.selectedSegmentIndex = durationUserDefault.integer(forKey: "durationUserDefault")
        difficultyLabel.selectedSegmentIndex = difficultyUserDefault.integer(forKey: "difficultyUserDefault")
        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)
        }
    
    
    
    
    func displayHighScore() {
//        highScoreLabel.text = "High score: \(highscore)"
        switch (timerDuration, chosenDifficulty) {
            case (60, "easy") : highScoreLabel.text = "High score: \(oneMinuteEasyHighScore)"
            case (120, "easy"): highScoreLabel.text = "High score: \(twoMinutesEasyHighScore)"
            case (300, "easy"): highScoreLabel.text = "High score: \(fiveMinutesEasyHighScore)"
            case (600, "easy"): highScoreLabel.text = "High score: \(tenMinutesEasyHighScore)"
            
            case (60, "medium"): highScoreLabel.text = "High score: \(oneMinuteMediumHighScore)"
            case (120, "medium"): highScoreLabel.text = "High score: \(twoMinutesMediumHighScore)"
            case (300, "medium"): highScoreLabel.text = "High score: \(fiveMinutesMediumHighScore)"
            case (600, "medium"): highScoreLabel.text = "High score: \(tenMinutesMediumHighScore)"

            case (60, "hard"): highScoreLabel.text = "High score: \(oneMinuteHardHighScore)"
            case (120, "hard"): highScoreLabel.text = "High score: \(twoMinutesHardHighScore)"
            case (300, "hard"): highScoreLabel.text = "High score: \(fiveMinutesHardHighScore)"
            case (600, "hard"): highScoreLabel.text = "High score: \(tenMinutesHardHighScore)"

            case (60, "expert"): highScoreLabel.text = "High score: \(oneMinuteExpertHighScore)"
            case (120, "expert"): highScoreLabel.text = "High score: \(twoMinuteExpertHighScore)"
            case (300, "expert"): highScoreLabel.text = "High score: \(fiveMinuteExpertHighScore)"
            case (600, "expert"): highScoreLabel.text = "High score: \(tenMinuteExpertHighScore)"

            default: print("Error in game settings switch")
        }
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
                selectedDuration = 0

        case 1: print("2 minutes")
                timerDuration = 120
                selectedDuration = 1
        case 2: print("5 minutes")
                timerDuration = 300
                selectedDuration = 2
        case 3: print("10 minutes")
                timerDuration = 600
                selectedDuration = 3
        default: print("error")
                selectedDuration = 0
        }
        durationUserDefault.set(selectedDuration, forKey: "durationUserDefault")
        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)
        
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
        
        difficultyUserDefault.set(selectedDifficulty, forKey: "difficultyUserDefault")
        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)

    }
    
    
        
}
