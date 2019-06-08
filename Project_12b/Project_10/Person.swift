//
//  Person.swift
//  Project_10
//
//  Created by Owen Henley on 28/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
