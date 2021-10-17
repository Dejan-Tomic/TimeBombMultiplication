//
//  ViewController.swift
//  TimeBombMultiplication
//
//  Created by Dejan Tomic on 03/05/2020.
//  Copyright © 2020 Dejan Tomic. All rights reserved.
//

import UIKit
import AVFoundation

extension UITextField {
    
    // Tool bar for 'Done' button above keyboard
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor(red: 0.8745, green: 0.8470, blue: 0.729, alpha: 1)
        toolBar.backgroundColor = UIColor(red: 0.8745, green: 0.8470, blue: 0.729, alpha: 1)
        toolBar.setItems([flexible, barButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var userAnswerTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Main screen loaded")
        displayQuestion()

        userAnswerTextField.isEnabled = false
        self.userAnswerTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
        
        timerLabel.text = "\(timerDuration)"
        
        scoreLabel.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("Main screen will appear")
        gameSettings(timeSetting: timerDuration, difficultySetting: chosenDifficulty ?? "easy")
        printHighScores()
        print("Current highscore is \(currentHighScore)")
    }
    
    // 'Done' button above keyboard is tapped
    @objc func tapDone() {
        
        self.view.endEditing(true)
        
        rightOrWrongAnswerBuzzer()
        displayQuestion()
        calculateAnswer()
        userAnswerTextField.text = ""
    }
    
    
    func rightOrWrongAnswerBuzzer() {
        
        if userAnswerTextField.text == String(correctAnswer) {
            
            play(sound: "rightAnswer")
            score += 1
            scoreLabel.text = "score: \(score)"

        } else {
            
            play(sound: "wrongAnswer")
        }
    }
    
    func displayQuestion() {
        
        nextQuestion(difficulty: chosenDifficulty ?? "easy")
        firstNumberLabel.text = "\(firstNumber)"
        secondNumberLabel.text = "\(secondNumber)"
    }
    
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        
        displayQuestion()
        calculateAnswer()

        scoreLabel.isHidden = false

        userAnswerTextField.isEnabled = true
        
        score = 0
        
        scoreLabel.text = "score: \(score)"
        
        runTimer()
        settingsButton.isHidden = true

    }
    
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        
        if timeLeft > 0 {
            
            timeLeft -= 1
            
            timerLabel.text = "\(timeLeft)"
            
            newGameButton.isHidden = true
            
//            settingsButton.isEnabled = false
            settingsButton.isHidden = true
            
        } else {
            
            play(sound: "alarm")
            
            timer.invalidate()
            
            userAnswerTextField.resignFirstResponder()
            
            timeLeft = timerDuration
            
            userAnswerTextField.isEnabled = false
            
            newGameButton.isHidden = false
            settingsButton.isHidden = false
            scoreLabel.isHidden = true

            checkScoreAgainstHighScore()
            printHighScores()
            newHighScoreAlert()
        }
    }
    
    
    func newHighScoreAlert() {
        
        if score > currentHighScore {
            
            let alert = UIAlertController(title: "Congratulations!", message: "You've reached a new high score!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } 
    }
}
 
