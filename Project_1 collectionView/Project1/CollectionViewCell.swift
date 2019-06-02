//
//  CollectionViewCell.swift
//  Project1
//
//  Created by Owen Henley on 02/06/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        layer.cornerRadius = 8
    }
    
}
