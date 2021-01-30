//
//  FruitTexture.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/29.
//

import Foundation

enum FruitTexture: String, CaseIterable {
    case cherry = "cherry"
    case cocount = "cocount"
    case grape = "grape"
    case halfwatermelon = "halfwatermelon"
    case kiwi = "kiwi"
    case lemon = "lemon"
    case orange = "orange"
    case peach = "peach"
    case pineapple = "pineapple"
    case tomato = "tomato"
    case watermelon = "watermelon"
    
    
    var name: String {
        rawValue
    }
    
    var bitmask: UInt32 {
        switch self {
        case .cherry: return 1 << 1
        case .cocount: return 1 << 2
        case .grape: return 1 << 3
        case .halfwatermelon: return 1 << 4
        case .kiwi: return 1 << 5
        case .lemon: return 1 << 6
        case .orange: return 1 << 7
        case .peach: return 1 << 8
        case .pineapple: return 1 << 9
        case .tomato: return 1 << 10
        case .watermelon: return 1 << 11
        }
    }
}
