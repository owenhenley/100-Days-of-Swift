//
//  DetailViewController.swift
//  Day23Challenge
//
//  Created by Owen Henley on 02/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var image: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }

    func loadImage() {
        imageView.image = UIImage(named: image)
    }
}
