//
//  ViewController.swift
//  Project_7
//
//  Created by Owen Henley on 12/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var petitions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Subtitle"
        return cell
    }

}

