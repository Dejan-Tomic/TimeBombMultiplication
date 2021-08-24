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
    
    @IBOutlet weak var difficultySegementedControl: UISegmentedControl!
    
    @IBOutlet weak var durationSegementedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Settings screen loaded")
//        displayHighScore()
//        printHighScores()

        durationSegementedControl.selectedSegmentIndex = selectedDuration

        difficultySegementedControl.selectedSegmentIndex = selectedDifficulty

//        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)
                
        }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Settings screen appeared")

        super.viewDidAppear(false)
        displayHighScore()
        printHighScores()


        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)
    }
    
   
    
    @IBAction func resetHighscoreButtonPressed(_ sender: UIButton) {
        
        resetHighScore()
        printHighScores()
        displayHighScore()
//        displayResetHighScore()
        
    }
    
    func displayHighScore() {
        
        switch (timerDuration, chosenDifficulty) {
        
            case (60, "easy") : highScoreLabel.text = "High score: \(oneMinuteEasyHighScore)"
                                currentHighScore = oneMinuteEasyHighScore
                
            case (120, "easy"): highScoreLabel.text = "High score: \(twoMinutesEasyHighScore)"
                                currentHighScore = twoMinutesEasyHighScore
                
            case (300, "easy"): highScoreLabel.text = "High score: \(fiveMinutesEasyHighScore)"
                                currentHighScore = fiveMinutesEasyHighScore
                
            case (600, "easy"): highScoreLabel.text = "High score: \(tenMinutesEasyHighScore)"
                                currentHighScore = tenMinutesEasyHighScore
            
            
            case (60, "medium"): highScoreLabel.text = "High score: \(oneMinuteMediumHighScore)"
                                 currentHighScore = oneMinuteMediumHighScore
                
            case (120, "medium"): highScoreLabel.text = "High score: \(twoMinutesMediumHighScore)"
                                  currentHighScore = twoMinutesMediumHighScore
                
            case (300, "medium"): highScoreLabel.text = "High score: \(fiveMinutesMediumHighScore)"
                                  currentHighScore = fiveMinutesMediumHighScore
                
            case (600, "medium"): highScoreLabel.text = "High score: \(tenMinutesMediumHighScore)"
                                  currentHighScore = tenMinutesMediumHighScore
            
            
            case (60, "hard"): highScoreLabel.text = "High score: \(oneMinuteHardHighScore)"
                               currentHighScore = oneMinuteHardHighScore
                
            case (120, "hard"): highScoreLabel.text = "High score: \(twoMinutesHardHighScore)"
                                currentHighScore = twoMinutesHardHighScore
                
            case (300, "hard"): highScoreLabel.text = "High score: \(fiveMinutesHardHighScore)"
                                currentHighScore = fiveMinutesHardHighScore
                
            case (600, "hard"): highScoreLabel.text = "High score: \(tenMinutesHardHighScore)"
                                currentHighScore = tenMinutesHardHighScore

            
            case (60, "expert"): highScoreLabel.text = "High score: \(oneMinuteExpertHighScore)"
                                 currentHighScore = oneMinuteExpertHighScore
                
            case (120, "expert"): highScoreLabel.text = "High score: \(twoMinuteExpertHighScore)"
                                  currentHighScore = twoMinuteExpertHighScore
                
            case (300, "expert"): highScoreLabel.text = "High score: \(fiveMinuteExpertHighScore)"
                                  currentHighScore = fiveMinuteExpertHighScore
                
            case (600, "expert"): highScoreLabel.text = "High score: \(tenMinuteExpertHighScore)"
                                  currentHighScore = tenMinuteExpertHighScore

            default: print("Error in game settings switch")
        }
    }
    
    
    // Not being used
    func displayResetHighScore() {
        
        switch (timerDuration, chosenDifficulty) {
        case (60, "easy") : highScoreLabel.text = "High score: 0"
                            currentHighScore = oneMinuteEasyHighScore
            
        case (120, "easy"): highScoreLabel.text = "High score: 0"
                            currentHighScore = twoMinutesEasyHighScore
            
        case (300, "easy"): highScoreLabel.text = "High score: 0"
                            currentHighScore = fiveMinutesEasyHighScore
            
        case (600, "easy"): highScoreLabel.text = "High score: 0"
                            currentHighScore = tenMinutesEasyHighScore
        
        
        case (60, "medium"): highScoreLabel.text = "High score: 0"
                             currentHighScore = oneMinuteMediumHighScore
            
        case (120, "medium"): highScoreLabel.text = "High score: 0"
                              currentHighScore = twoMinutesMediumHighScore
            
        case (300, "medium"): highScoreLabel.text = "High score: 0"
                              currentHighScore = fiveMinutesMediumHighScore
            
        case (600, "medium"): highScoreLabel.text = "High score: 0"
                              currentHighScore = tenMinutesMediumHighScore
        
        
        case (60, "hard"): highScoreLabel.text = "High score: 0"
                           currentHighScore = oneMinuteHardHighScore
            
        case (120, "hard"): highScoreLabel.text = "High score: 0"
                            currentHighScore = twoMinutesHardHighScore
            
        case (300, "hard"): highScoreLabel.text = "High score: 0"
                            currentHighScore = fiveMinutesHardHighScore
            
        case (600, "hard"): highScoreLabel.text = "High score: 0"
                            currentHighScore = tenMinutesHardHighScore

        
        case (60, "expert"): highScoreLabel.text = "High score: 0"
                             currentHighScore = oneMinuteExpertHighScore
            
        case (120, "expert"): highScoreLabel.text = "High score: 0"
                              currentHighScore = twoMinuteExpertHighScore
            
        case (300, "expert"): highScoreLabel.text = "High score: 0"
                              currentHighScore = fiveMinuteExpertHighScore
            
        case (600, "expert"): highScoreLabel.text = "High score: 0"
                              currentHighScore = tenMinuteExpertHighScore
            
        default: print("Error in game settings switch")
        }
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
                timerDuration = 60
                selectedDuration = 0

                    
        }
        
//        durationUserDefault.set(selectedDuration, forKey: "durationSegmentUserDefault")

        durationUserDefault.set(timerDuration, forKey: "durationUserDefault")
        durationUserDefault.set(selectedDuration, forKey: "selectedDurationUserDefault")

        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)

        displayHighScore()
        
    }
    
    
    @IBAction func difficultySelected(_ sender: UISegmentedControl) {
        
        switch difficultySegementedControl.selectedSegmentIndex {
        case 0: chosenDifficulty = "easy"
                selectedDifficulty = 0
            
        case 1: chosenDifficulty = "medium"
                selectedDifficulty = 1
            
        case 2: chosenDifficulty = "hard"
                selectedDifficulty = 2
            
        case 3: chosenDifficulty = "expert"
                selectedDifficulty = 3
            
        default: chosenDifficulty = "easy"
                 selectedDifficulty = 0

        }
        
        difficultyUserDefault.set(selectedDifficulty, forKey: "difficultyUserDefault")
        
        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty)
        
        displayHighScore()
        
    }
    
    
        
}
