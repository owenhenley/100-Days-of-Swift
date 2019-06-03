//
//  GameScene.swift
//  Project_11
//
//  Created by Owen Henley on 03/06/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        makeBoucer(at: CGPoint(x: 0, y: 0))
        makeBoucer(at: CGPoint(x: 256, y: 0))
        makeBoucer(at: CGPoint(x: 512, y: 0))
        makeBoucer(at: CGPoint(x: 768, y: 0))
        makeBoucer(at: CGPoint(x: 1024, y: 0))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let location = touch.location(in: self)
        let ball = SKSpriteNode(imageNamed: "ballRed")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.restitution = 0.5
        ball.position = location
        addChild(ball)
    }

    func makeBoucer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
