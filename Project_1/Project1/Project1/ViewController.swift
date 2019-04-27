//
//  ViewController.swift
//  Project1
//
//  Created by Owen Henley on 27/04/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var photosAsString = [String]()

    private let nssl = "nssl"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFileManager()
    }

    /// Setup the file manager
    ///
    /// This is used to setup the file manager to access the images saved to our
    /// Bundle resource path.
    private func setupFileManager() {
        let manager = FileManager.default
        let path = Bundle.main.resourcePath! // iOS NEEDS a resourcepath, so we can force it. Pulling from project navigator, *not* assets.
        let items = try! manager.contentsOfDirectory(atPath: path) // If we cant read the app bundle, teh app wont work anyway, so we can force try

        for item in items {
            if item.hasPrefix(nssl) {
                photosAsString.append(item)
            }
        }
        print(photosAsString)
    }
}

