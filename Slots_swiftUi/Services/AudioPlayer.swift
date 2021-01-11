//
//  AudioPlayer.swift
//  Slots_swiftUi
//
//  Created by Sergey on 11.01.2021.
//

import AVFoundation

private var audioPlayer: AVAudioPlayer?

func playSound(name: String, format: String) {
    
    if let path = Bundle.main.path(forResource: name, ofType: format) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("File did find")
        }
    }
}
