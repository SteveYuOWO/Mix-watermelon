//
//  GameScene.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/28.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var nowFruit: SKSpriteNode!
    var scoreNode: SKSpriteNode!
    
    var score: Int = 0 {
        didSet {
            updateScore()
        }
    }
    
    var groundFruits: [SKSpriteNode] = []
    
    var fruitUtil: FruitUtil!
    
    var ground: SKSpriteNode!
    
    let falldownAudio = AudioUtil(resourceName: "falldown")
    let winAudio = AudioUtil(resourceName: "win")
    let bombAudio = AudioUtil(resourceName: "bomb")
    
    
    var groundCollision = false
    
    
    var redline: SKSpriteNode!
    var isShowingRedline = false
    
    var gameover = false
    var gameoverNode: SKSpriteNode!
    var restart: SKSpriteNode!
    
    func initGame() {
        fruitUtil = FruitUtil()
        
        makeUI()
        makeNowFruit()
        makeScoreNode()
        makeRedline()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameover { return }
        
        if isShowingRedline {
            for fruit in groundFruits {
                if fruit.position.y > screen.height - 80 {
                    gameover = true
                    loadingGameover()
                    break
                }
            }
        }
        
        if isShowingRedline {
            if !checkWillShowingRedline() {
                showOutRedline()
                isShowingRedline = false
            }
        } else {
            if checkWillShowingRedline() {
                showInRedline()
                isShowingRedline = true
            }
        }
    }
    
    private func checkWillShowingRedline()->Bool {
        for fruit in groundFruits {
            if fruit.position.y > screen.height - 80 - 150 {
                return true
            }
        }
        return false
    }
}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
