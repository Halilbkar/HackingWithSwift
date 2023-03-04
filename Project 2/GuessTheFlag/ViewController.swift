//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Halil Bakar on 4.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    var totalQuestion = 0
    var correct = 0
    var wrong = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        buttonConfig() 
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(scoreTapped))
    }
    
    @objc func scoreTapped() {

        let ac = UIAlertController(title: "Score", message: "Correct: \(correct) - Wrong: \(wrong)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Contine", style: .default))
        
        present(ac, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            correct += 1
        } else {
            title = "Wrong! This is \(countries[sender.tag].uppercased()) flag"
            score -= 1
            wrong += 1
        }
        
        totalQuestion += 1
        
        if totalQuestion == 10 {
            
            alert(title: title, message: "Correct: \(correct) - Wrong: \(wrong)", actionTitle: "New Game")
            
            newGame()
            
        } else {
           
            alert(title: title, message: "Your score is \(score)", actionTitle: "Contine")
        }
    }
    
    func alert(title: String, message: String, actionTitle: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    func newGame() {
        
        totalQuestion = 0
        score = 0
        correct = 0
        wrong = 0
    }
    
    func buttonConfig() {
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
}

