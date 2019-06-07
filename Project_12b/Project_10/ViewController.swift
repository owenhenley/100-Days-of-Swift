//
//  ViewController.swift
//  Project_10
//
//  Created by Owen Henley on 27/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    @objc private func addNewPerson() {
        let picker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            print("Using camera")
        } else {
            print("Opening Library")
        }

        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "person", for: indexPath) as? PersonCell else {
            fatalError("Not able to use custom person cell")
        }

        let person = people[indexPath.item]

        cell.nameLabel.text = person.name
        let imagePath = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: imagePath.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        let ac = UIAlertController(title: "Rename or delete?", message: "Would you like to rename, or delete this image?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { _ in
            self.rename(person: person)
        }))
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.people.remove(at: indexPath.row)
            self.collectionView.reloadData()
        }))

        present(ac, animated: true)
    }

    private func rename(person: Person) {
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?.first?.text else {
                return
            }
            person.name = newName
            self?.collectionView.reloadData()
        })
        present(ac, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            // could fail on RAW image
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()

        dismiss(animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    // No code
}

