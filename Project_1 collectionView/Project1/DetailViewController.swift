//
//  DetailViewController.swift
//  Project1
//
//  Created by Owen Henley on 28/04/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    var selectedImage: String?
    var imageIndex: Int?
    var totalImages: Int?

    // MARK: - Outlets
    @IBOutlet var photoImageView: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    // MARK: - Methods
    /// Set up the image to view.
    ///
    /// Will check the selected image to confim which image to show.
    private func setupImage() {
        if let imageToLoad = selectedImage {
            photoImageView.image = UIImage(named: imageToLoad)
        }
    }

    /// Setup how nevigation should be displayed.
    private func setupNavigation() {
        title = "Photo \((imageIndex ?? 0) + 1) of \(totalImages ?? 0)"
        navigationItem.largeTitleDisplayMode = .never
    }
}
