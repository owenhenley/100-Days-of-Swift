//
//  ViewController.swift
//  Project1
//
//  Created by Owen Henley on 27/04/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    // MARK: - Properties
    private let cellId = "tableViewCell"
    private let detailsId = "Details"
    private var photosAsString = [String]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFileManager()
        setupNavigation()
    }

    // MARK: - Methods
    /// Setup the file manager.
    ///
    /// This is used to setup the file manager to access the images saved to our
    /// Bundle resource path.
    private func setupFileManager() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let manager = FileManager.default
            let path = Bundle.main.resourcePath! // iOS NEEDS a resourcepath, so we can force it. Pulling from project navigator, *not* assets.
            let items = try! manager.contentsOfDirectory(atPath: path) // If we cant read the app bundle, teh app wont work anyway, so we can force try

            for item in items {
                if item.hasPrefix("nssl") {
                    self?.photosAsString.append(item)
                }
            }

            self?.photosAsString.sort()
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }

    /// Setup how teh navigation should be displayed.
    private func setupNavigation() {
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Setup table view
extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosAsString.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot use custom cell")
        }
        cell.titleLabel.text = photosAsString[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailsVc = storyboard?.instantiateViewController(withIdentifier: detailsId) as? DetailViewController {
            detailsVc.selectedImage = photosAsString[indexPath.row]
            detailsVc.imageIndex = indexPath.row
            detailsVc.totalImages = photosAsString.count
            navigationController?.pushViewController(detailsVc, animated: true)
        }
    }
}
