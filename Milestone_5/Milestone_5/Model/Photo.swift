//
//  Photo.swift
//  Milestone_5
//
//  Created by Owen Henley on 15/06/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class Photo: NSObject, Codable {
    var image: String
    var caption: String

    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }

    required init?(coder: NSCoder) {
        image = coder.decodeObject(forKey: "image") as? String ?? ""
        caption = coder.decodeObject(forKey: "caption") as? String ?? ""
    }

    func encode(with coder: NSCoder) {
        coder.encode(caption, forKey: "caption")
        coder.encode(image, forKey: "image")
    }
}
