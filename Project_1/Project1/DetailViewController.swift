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

    // MARK: - Outlets
    @IBOutlet var photoImageView: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
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
}
