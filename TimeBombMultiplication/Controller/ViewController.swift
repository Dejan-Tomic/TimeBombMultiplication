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

            setHighScore()
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
 
