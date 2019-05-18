//
//  ViewController.swift
//  Milestone_4
//
//  Created by Owen Henley on 18/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let wordLabel = UILabel()
    var lettersGrid = [UIButton]()

    override func loadView() {
        super.loadView()
        wordLabel.text = "hloeodewionoern"
        wordLabel.font = UIFont.systemFont(ofSize: 30)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordLabel)

        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)

        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

