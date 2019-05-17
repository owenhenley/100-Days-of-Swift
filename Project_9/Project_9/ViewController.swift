//
//  ViewController.swift
//  Project_7
//
//  Created by Owen Henley on 12/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var petitions = [Petition]()
    private var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPetitions()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterAlert))
        let clearFilterButton = UIBarButtonItem(title: "Clear Filter", style: .plain, target: self, action: #selector(clearFilter))
        navigationItem.setRightBarButtonItems([filterButton, clearFilterButton], animated: true)
    }

    @objc func clearFilter() {
        filteredPetitions.removeAll()
        reloadTableView()
    }

    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "This app uses the We the People API, but is neither endorsed nor certified by the White House.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(ac, animated: true)
    }

    @objc private func fetchPetitions() {
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
    }


    private func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }

    @objc func showFilterAlert() {
        let ac = UIAlertController(title: "Filter Results", message: "Enter a query to filter the results.", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Filter", style: .default) { _ in
            if let query = ac.textFields?.first?.text {
                self.filterPetitions(filter: query)
            }
        })
        present(ac, animated: true)
    }

    private func filterPetitions(filter: String) {
        filteredPetitions = petitions.filter {
            $0.body.lowercased().contains(filter) || $0.title.lowercased().contains(filter)
        }
        reloadTableView()
    }

    private func reloadTableView() {
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }

    private func parse(json:Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.isEmpty ? petitions.count : filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if !filteredPetitions.isEmpty {
            let filteredPetition = filteredPetitions[indexPath.row]
            cell.textLabel?.text = filteredPetition.title
            cell.detailTextLabel?.text = filteredPetition.body
        } else {
            let petition = petitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

