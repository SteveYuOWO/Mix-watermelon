//
//  ContentView.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/28.
//

import SwiftUI
import SpriteKit

let screen = UIScreen.main.bounds

struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene()
        
        scene.size = CGSize(width: screen.width, height: screen.height)
        
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: screen.width, height: screen.height)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
