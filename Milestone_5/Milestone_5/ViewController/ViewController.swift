//
//  ViewController.swift
//  Milestone_5
//
//  Created by Owen Henley on 15/06/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let defaults = UserDefaults.standard

    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

// MARK: - UITableView

extension ViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]

        let ac = UIAlertController(title: "Edit Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] action in
            let tf = ac.textFields?.first
            if let newCaption = tf?.text {
                photo.caption = newCaption
                self?.save()
                self?.tableView.reloadData()
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? TableViewCell else {
            fatalError("Can't use custom cell")
        }

        let photo = photos[indexPath.row]
        let imagePath = getDocumentsDirectory().appendingPathComponent(photo.image)

        cell.savedImageView.image = UIImage(contentsOfFile: imagePath.path)
        cell.captionLabel.text = photo.caption
        
        return cell
    }
}

// MARK: - Persistance

private extension ViewController {
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(photos) {
            defaults.set(savedData, forKey: "photos")
        } else {
            print("Failed to save photos")
        }
    }

    func load() {
        let jsonDecoder = JSONDecoder()
        if let savedPhotos = defaults.object(forKey: "photos") as? Data {
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
            } catch {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Camera Methods

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func takePhoto() {
        let picker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }

        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)

    }

    private func editCaption(action: UIAlertAction) {

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let photo = Photo(image: imageName, caption: "Edit to add a caption")
        photos.append(photo)
        save()
        tableView.reloadData()

        dismiss(animated: true)
    }
}
