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
//        print("High score is \(highscore)")

        print("1 minute easy score is \(oneMinuteEasyHighScore)") // Should be 23
        print("1 minute medium score is \(oneMinuteMediumHighScore)") // Should be 5
        print("1 minute hard score is \(oneMinuteHardHighScore)") // Should be 8
        print("1 minute expert score is \(oneMinuteExpertHighScore)") // Should be 6 or 9?

        print("2 minutes easy score is \(twoMinutesEasyHighScore)") // Should be 0
        print("2 minutes medium score is \(twoMinutesMediumHighScore)") // Should be 0
        print("2 minutes hard score is \(twoMinutesHardHighScore)") // Should be 0 10
        print("2 minutes expert score is \(twoMinuteExpertHighScore)") // Inccorectly saves to 1 min expert
        
        print("5 minutes easy score is \(fiveMinutesEasyHighScore)") // Should be 0
        print("5 minutes medium score is \(fiveMinutesMediumHighScore)") // Should be 0
        print("5 minutes hard score is \(fiveMinutesHardHighScore)") // Should be 0
        print("5 minutes expert score is \(fiveMinuteExpertHighScore)") // Should be 0
        
        print("10 minutes easy score is \(tenMinutesEasyHighScore)") // Should be 0
        print("10 minutes medium score is \(tenMinutesMediumHighScore)") // Should be 0
        print("10 minutes hard score is \(tenMinutesHardHighScore)") // Should be 0
        print("10 minutes expert score is \(tenMinuteExpertHighScore)") // Should be 0




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
//        setHighScore()
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
        if timerDuration > 0 {
            timerDuration -= 1
            timerLabel.text = "\(timerDuration)"
            newGameButton.isHidden = true
            settingsButton.isEnabled = false
        } else {
            play(sound: "alarm")
            timer.invalidate()
            userAnswerTextField.resignFirstResponder()
            timerDuration = 60
            userAnswerTextField.isEnabled = false
            newGameButton.isHidden = false
            settingsButton.isEnabled = true

//            setHighScore()
            checkScoreAgainstHighScore()
            newHighScoreAlert()
        }
    }
    
    
    func newHighScoreAlert() {
        if score > highscore {
            let alert = UIAlertController(title: "Congratulations!", message: "You've reached a new high score!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
}
 
