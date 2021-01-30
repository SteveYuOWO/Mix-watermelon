//
//  FruitUtil.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/28.
//

import Foundation
import SpriteKit

class FruitUtil {
    private let randomList = [
        FruitTexture.grape,
        FruitTexture.cherry,
        FruitTexture.orange,
        FruitTexture.lemon,
        FruitTexture.kiwi
    ]
    
    private var randomCnt = 0
    
    private let mixList = [
        FruitTexture.grape,
        FruitTexture.cherry,
        FruitTexture.orange,
        FruitTexture.lemon,
        FruitTexture.kiwi,
        FruitTexture.tomato,
        FruitTexture.peach,
        FruitTexture.pineapple,
        FruitTexture.cocount,
        FruitTexture.halfwatermelon,
        FruitTexture.watermelon
    ]
    
    func getFruitScore(fruitName: String) -> Int {
        mixList.firstIndex{ $0.name == fruitName }! + 1
    }
    
    func mixFruit(fruitName: String) -> SKSpriteNode? {
        let index = mixList.firstIndex{ fruitName == $0.name }
        if index == nil || index! == mixList.count - 1 {
            print("fatal error: fruitName not found")
            return nil
        }
        let name = mixList[index! + 1].name
        let fruit = SKSpriteNode(imageNamed: name)
        fruit.name = name
        return fruit
    }
    
    func randomFruit() -> SKSpriteNode {
        randomCnt += 1
        var fruit: SKSpriteNode
        var name: String
        switch randomCnt {
        case 1...3:
            name = FruitTexture.grape.name
        case 4:
            name = FruitTexture.cherry.name
        case 5:
            name = FruitTexture.orange.name
        default:
            name = randomList.randomElement()!.name
        }
        fruit = SKSpriteNode(imageNamed: name)
        fruit.position = CGPoint(x: screen.width / 2, y: screen.height - 50)
        fruit.setScale(0.5)
        fruit.name = name
        return fruit
    }
    
    func getFruitTextureByName(fruitName: String) -> FruitTexture {
        FruitTexture.allCases.first{ $0.name == fruitName }!
    }
}
