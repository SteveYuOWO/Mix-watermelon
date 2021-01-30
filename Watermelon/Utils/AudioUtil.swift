//
//  AudioUtil.swift
//  Watermelon
//
//  Created by Steve Yu on 2021/1/29.
//

import Foundation
import AVFoundation

class AudioUtil {
    
    var resourceName: String
    
    var player: AVAudioPlayer!
    
    var playing = false
    
    init(resourceName: String) {
        self.resourceName = resourceName
    }
    func playAudio() {
        if playing { return }
        guard let fileUrl = Bundle.main.url(forResource: resourceName, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: fileUrl)
            player.prepareToPlay()
            player.play()
            playing = true
        } catch let err {
            print(err.localizedDescription)
        }
        
        Timer(timeInterval: 1, repeats: false) { _ in
            self.playing = false
        }.fire()
    }
}
