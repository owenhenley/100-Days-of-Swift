//
//  ViewController.swift
//  Project1
//
//  Created by Owen Henley on 27/04/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let nssl = "nssl"
    private let cellId = "tableViewCell"
    private var photosAsString = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFileManager()
    }

    /// Setup the file manager.
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
    }

    // MARK: - Setup table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosAsString.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = photosAsString[indexPath.row]
        return cell
    }
}
