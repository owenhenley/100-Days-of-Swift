//
//  ViewController.swift
//  Day23Challenge
//
//  Created by Owen Henley on 02/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFileManager()
    }

    private func setupFileManager() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasSuffix("png") {
                self.items.append(item)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let country = items[indexPath.row].capitalized
        let name = country.split(separator: "@").map(String.init).first
        cell.textLabel?.text = name
        cell.imageView?.image = UIImage(named: items[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        if let detailVc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            detailVc.image = items[indexPath.row]
            navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}

