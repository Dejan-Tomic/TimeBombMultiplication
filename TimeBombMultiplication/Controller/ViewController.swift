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
    
    func addInputAccessoryView(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
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
        // Do any additional setup after loading the view.
        displayQuestion()
        calculateAnswer()
        userAnswerTextField.isEnabled = false
        self.userAnswerTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))
        timerLabel.text = "\(timerDuration)"
        printHighScores()

    }
    
    func printHighScores() {
        print("1 minute easy score is \(oneMinuteEasyHighScore)") // Should be 25
        print("1 minute medium score is \(oneMinuteMediumHighScore)") // Should be 9
        print("1 minute hard score is \(oneMinuteHardHighScore)") // Should be 8
        print("1 minute expert score is \(oneMinuteExpertHighScore)") // Should be 11

        print("2 minutes easy score is \(twoMinutesEasyHighScore)") // Should be 27
        print("2 minutes medium score is \(twoMinutesMediumHighScore)") // Should be 7
        print("2 minutes hard score is \(twoMinutesHardHighScore)") // Should be 9
        print("2 minutes expert score is \(twoMinuteExpertHighScore)") // Should be 15
        
        print("5 minutes easy score is \(fiveMinutesEasyHighScore)") // Should be 30
        print("5 minutes medium score is \(fiveMinutesMediumHighScore)") // Should be 12
        print("5 minutes hard score is \(fiveMinutesHardHighScore)") // Should be 10
        print("5 minutes expert score is \(fiveMinuteExpertHighScore)") // Should be 16
          
        print("10 minutes easy score is \(tenMinutesEasyHighScore)") // Should be 33
        print("10 minutes medium score is \(tenMinutesMediumHighScore)") // Should be 14
        print("10 minutes hard score is \(tenMinutesHardHighScore)") // Should be 13
        print("10 minutes expert score is \(tenMinuteExpertHighScore)") // Should be 17
    }
    
        
    
    @objc func tapDone() { 
        self.view.endEditing(true)
        checkAnswer()
        displayQuestion()
        calculateAnswer()
        userAnswerTextField.text = ""
    }
    
    
    func checkAnswer() {
        if userAnswerTextField.text == String(correctAnswer) {
            print("correct")
            play(sound: "rightAnswer")
            score += 1
            
        } else {
            print("incorrect")
            play(sound: "wrongAnswer")
        }
        scoreLabel.text = "score: \(score)"
        checkScoreAgainstHighScore()
        
    }
    
    func displayQuestion() {
        print(chosenDifficulty)
        nextQuestion(difficulty: chosenDifficulty)
        firstNumberLabel.text = "\(firstNumber)" 
        secondNumberLabel.text = "\(secondNumber)"
    }
    
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        userAnswerTextField.isEnabled = true
        score = 0
        scoreLabel.text = "score: \(score)"
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        
        if timeLeft > 0 {
            timeLeft -= 1
            timerLabel.text = "\(timeLeft)"
            newGameButton.isHidden = true
            settingsButton.isEnabled = false
        } else {
            play(sound: "alarm")
            timer.invalidate()
            userAnswerTextField.resignFirstResponder()
            timeLeft = timerDuration
            userAnswerTextField.isEnabled = false
            newGameButton.isHidden = false
            settingsButton.isEnabled = true

            checkScoreAgainstHighScore()
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
 
