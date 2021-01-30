//
//  GameScene+RedLine.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/29.
//

import SpriteKit
import SwiftUI

extension GameScene {
    func makeRedline() {
        redline = SKSpriteNode(imageNamed: "redline")
        redline.anchorPoint = CGPoint.zero
        redline.position = CGPoint(x: 0, y: screen.height - 80)
        // screen.height - 80 - 150
        addChild(redline)
        redline.setScale(0)
        redline.run(.repeat(.sequence([
            .fadeIn(withDuration: 0.4),
            .fadeOut(withDuration: 0.4)
        ]), count: -1))
    }
    
    func showInRedline() {
        redline.setScale(1)
    }
    
    func showOutRedline() {
        redline.setScale(0)
    }
}
