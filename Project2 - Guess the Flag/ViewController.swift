//
//  ViewController.swift
//  Project2 - Guess the Flag
//
//  Created by John Kim on 1/20/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    // UIButton and CALayer
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    func askQuestion(action: UIAlertAction! = nil) {
        // Guess which flag: random numbers
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "Player score: \(score) Country: \(countries[correctAnswer].uppercased()) Q \(questionsAsked)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UIActivityViewController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(scoreTapped))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    @objc func scoreTapped() {
        let vc = UIActivityViewController(activityItems: ["Your current score is: \(score)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        questionsAsked += 1

        if (questionsAsked == 10) {
            let ac = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
            present(ac, animated: true)
            questionsAsked = 0
            score = 0
        }
        
        if (title == "Correct") {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Wrong! That's the flag of \(countries[sender.tag].capitalized)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
}

