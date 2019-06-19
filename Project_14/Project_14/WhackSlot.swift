//
//  WhackSlot.swift
//  Project_14
//
//  Created by Owen Henley on 19/06/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//


import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!

    func configure(at position: CGPoint) {
        self.position = position

        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)

        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)

        addChild(cropNode)
    }
}
