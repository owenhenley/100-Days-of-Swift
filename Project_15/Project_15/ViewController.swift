//
//  ViewController.swift
//  Project_15
//
//  Created by Owen Home on 30/06/2019.
//  Copyright © 2019 Owen Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            guard let imageView = self.imageView else { fatalError("No image view to transform") }
            switch self.currentAnimation {
            case 0:
                imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1:
                imageView.transform = .identity
            case 2:
                imageView.transform = CGAffineTransform(translationX: -256, y: -256)
            case 3:
                imageView.transform = .identity
            case 4:
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 5:
                imageView.transform = .identity
            case 6:
                imageView.alpha = 0.1
                imageView.backgroundColor = .green
            case 7:
                imageView.alpha = 1
                imageView.backgroundColor = .clear
            default:
                break
            }
        }) { finished in
            sender.isHidden = false
        }

        currentAnimation += 1

        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}

