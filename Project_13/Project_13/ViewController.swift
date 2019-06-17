//
//  ViewController.swift
//  Project_13
//
//  Created by Owen Henley on 14/06/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensitySlider: UISlider!
    var currentImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }

    @IBAction func intensityChanged(_ sender: Any) {
    }

    @IBAction func changeFilter(_ sender: Any) {
    }

    @IBAction func save(_ sender: Any) {
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
    }
}

