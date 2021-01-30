//
//  GameScene+Collisions.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/29.
//

import SpriteKit
import SwiftUI

// MARK: - Collisions
extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        if groundCollision { return }
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
       
        // ground collison
        for fruit in FruitTexture.allCases {
            let bit = fruit.bitmask | ground.physicsBody!.categoryBitMask
            if bit == collision {
                groundCollision = true
                falldownAudio.playAudio()
                Timer(timeInterval: 1, repeats: false) { _ in
                    self.groundCollision = false
                }.fire()
                break
            }
        }
        
        // fruit collision
        for fruit in FruitTexture.allCases {
            let fruitBit = fruit.bitmask | fruit.bitmask
            if fruitBit == collision {
                // bomb sound
                bombAudio.playAudio()
                
                // collision appear
                let nodeA = contact.bodyA.node!
                let nodeB = contact.bodyB.node!
                // two watermelon collision
                if nodeA.name == FruitTexture.watermelon.name {
                    return
                }
                // update score
                let score = fruitUtil.getFruitScore(fruitName: nodeA.name!)
                self.score += score
                // bonus
                if nodeA.name! == FruitTexture.halfwatermelon.name {
                    self.score += 100
                    showBonusAnimation()
                    // bonus audio
                    winAudio.playAudio()
                }
                
                // animation
                let newFruitPosition = CGPoint(
                    x: (nodeA.position.x + nodeB.position.x) / 2,
                    y: (nodeA.position.y + nodeB.position.y) / 2
                )
                run(.sequence([
                    .run {
                        nodeA.run(.fadeOut(withDuration: 0.1))
                        nodeB.run(.fadeOut(withDuration: 0.1))
                    },
                    .run {
                        nodeA.removeFromParent()
                        nodeB.removeFromParent()
                    },
                    .run {
                        self.generateNewFruitFromPosition(fruitName: nodeA.name!, position: newFruitPosition)
                    }
                ]))
                
            }
        }
    }
    
    func showBonusAnimation() {
        let bonusNode = SKSpriteNode()
        bonusNode.position = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        let gray = SKSpriteNode(color: UIColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4022575949)),
                                size: CGSize(width: screen.width,
                                             height: screen.height))
        
        let layer = SKSpriteNode()
        let watermelon = SKSpriteNode(imageNamed: FruitTexture.watermelon.name)
        let yellowlight = SKSpriteNode(imageNamed: "yellowlight")
        
        
        watermelon.setScale(0.3)
        
        layer.addChild(yellowlight)
        layer.addChild(watermelon)
        
        bonusNode.addChild(gray)
        bonusNode.addChild(layer)
    
        addChild(bonusNode)
        
        yellowlight.run(.rotate(byAngle: 30, duration: 30))
        
        layer.setScale(0.1)
        layer.position = CGPoint(x: 0, y: 50)
        layer.run(.sequence([
            .scale(to: 1, duration: 0.5),
            
            .wait(forDuration: 1),
            .scale(to: 0, duration: 0.5)
        ]))
        layer.run(.sequence([
            .moveTo(y: 150, duration: 0.1),
            .moveTo(y: 0, duration: 0.4),
            .wait(forDuration: 1),
            .moveTo(y: 500, duration: 0.5),
            .run {
                bonusNode.run(.fadeOut(withDuration: 0.1))
                bonusNode.removeFromParent()
            }
        ]))
        
    }
    
    func generateNewFruitFromPosition(fruitName: String, position: CGPoint) {
        // add new Fruit
        guard let fruit = fruitUtil.mixFruit(fruitName: fruitName) else { return }
        
        fruit.position = position
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.height/2)
        let bitmask = fruitUtil.getFruitTextureByName(fruitName: fruit.name!).bitmask
        fruit.physicsBody?.categoryBitMask = bitmask
        fruit.physicsBody?.contactTestBitMask = bitmask
        
        addChild(fruit)
        // animation
        fruit.setScale(0)
        fruit.run(.scale(to: 0.5, duration: 0.3))
        
        groundFruits.append(fruit)
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}

struct GameSceneCollisions_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
