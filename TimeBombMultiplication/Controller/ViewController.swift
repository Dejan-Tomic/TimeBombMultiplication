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
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

 var player: AVAudioPlayer?
 var timer = Timer()

class ViewController: UIViewController {
   
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var userAnswerTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayQuestion()
        calculateAnswer()
        newGameButton.layer.cornerRadius = 15
        userAnswerTextField.isEnabled = false

        self.userAnswerTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDone))

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
        setHighScore()

    }
    
    func displayQuestion() {
        print(chosenDifficulty)
        nextQuestion(difficulty: chosenDifficulty)
        firstNumberLabel.text = "\(firstNumber)" 
        secondNumberLabel.text = "\(secondNumber)"
    }
    
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        userAnswerTextField.isEnabled = true
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            }
    
     
    @objc func updateTimer() {
        if timerDuration > 0 {
            timerDuration -= 1
            timerLabel.text = "\(timerDuration)"
        } else {
            play(sound: "alarm")
            timer.invalidate()
            userAnswerTextField.resignFirstResponder()
            timerDuration = 60
            userAnswerTextField.isEnabled = false

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
    
 
    
    
    
}
