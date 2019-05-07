//
//  ViewController.swift
//  Project_5
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var allWords = [String]()
    private var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        startGame()
    }

    private func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        let errorTitle: String
        let errorMessage: String

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    errorTitle = "Word not recocnised"
                    errorMessage = "You cant just make a work up"
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original"
            }
        } else {
            errorTitle = "Work not possible"
            errorMessage = "You can't spell that from \(title!.lowercased())"
        }

        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }

    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")
        return misspelledRange.location == NSNotFound
    }

    @objc private func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction =  UIAlertAction(title: "Submit", style: .default) {
            // The view controller is used in the closure, and the alertc controller is used in the closure.
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

