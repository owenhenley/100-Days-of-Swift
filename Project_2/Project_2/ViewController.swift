//
//  ViewController.swift
//  Project_2
//
//  Created by Owen Henley on 29/04/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let defaults = UserDefaults.standard

    // MARK: - Outlets
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    // MARK: - Properties
    private var countries = [String]()
    private var score = 0
    private var highScore = 0
    private var correctAnswer = 0
    private var askedQuestions = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        addCountries()
        updateScore()
        loadHighScore()
    }

    // MARK: - Methods

    /// Setup the images.
    private func setupImages() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }

    /// Add the list of countries.
    private func addCountries() {
        countries += [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us",
        ]
        askQuestion()
    }


    /// Shows a new set of flags to gues from.
    ///
    /// - Parameter action: used for the action. Default is `nil`.
    private func askQuestion(action: UIAlertAction? = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].capitalized
        updateScore()
    }

    private func updateScore() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: nil, action: nil)
    }

    private func loadHighScore() {
        highScore = defaults.integer(forKey: "highScore")
    }

    private func saveHighScore() {
        defaults.set(highScore, forKey: "highScore")
    }

    // MARK: - Actions
    /// The action when a flag button is tapped.
    ///
    /// This will set the current score, and then present an alert showing weather or not your guess was correct.
    /// - Parameter sender: The flag button.
    @IBAction func buttonTapped(_ sender: UIButton) {
        askedQuestions += 1
        var title: String

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            sender..transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { (_) in

        }

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That was the flag of \(countries[sender.tag].capitalized)."
        }

        if askedQuestions <= 9 {
            let alertController = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true)
        } else {
            if score > highScore {
                highScore = score
                saveHighScore()

                let alertController = UIAlertController(title: title, message: "New High Score!: \(highScore). \nLet's Reset", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: askQuestion))

                askedQuestions = 0
                score = 0
                present(alertController, animated: true)
            } else {
                let alertController = UIAlertController(title: title, message: "Your total score is: \(score). Let's Reset", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: askQuestion))
                askedQuestions = 0
                score = 0
                present(alertController, animated: true)
            }
        }
    }
}
