//
//  ViewController.swift
//  Project_2
//
//  Created by Owen Henley on 29/04/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    // MARK: - Properties
    private var countries = [String]()
    private var score = 0
    private var correctAnswer = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        addCountries()
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

        title = countries[correctAnswer].uppercased()
    }

    // MARK: - Actions
    /// The action when a flag button is tapped.
    ///
    /// This will set the current score, and then present an alert showing weather or not your guess was correct.
    /// - Parameter sender: The flag button.
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        let alertController = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(alertController, animated: true)
    }
}
