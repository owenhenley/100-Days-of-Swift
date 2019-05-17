//
//  Petition.swift
//  Project_7
//
//  Created by Owen Henley on 12/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
