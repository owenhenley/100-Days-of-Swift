//
//  ViewController.swift
//  Milestone_3
//
//  Created by Owen Henley on 11/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        navigationItem.rightBarButtonItems = [add, share]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
    }

    @objc func shareList() {
        let list = items.joined(separator: ",")
        let av = UIActivityViewController(activityItems: [list], applicationActivities: [])
        av.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?[1]
        present(av, animated: true)
    }

    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: "Add an item to your shopping list.", preferredStyle: .alert)
        ac.addTextField { tf in
            tf.placeholder = "item"
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            if let item = ac.textFields?.first?.text {
                self.items.insert(item, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }))
        present(ac, animated: true)
    }

    @objc func clearList() {
        items.removeAll()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

