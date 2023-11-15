//
//  SoundService.swift
//  FlappyBird
//
//  Created by K4 on 14.11.2023.
//

import Foundation
import AVFoundation

class SoundService {
    var audioPlayer: AVAudioPlayer?

    func playSound(key: String) {
        guard let soundURL = Bundle.main.url(forResource: key, withExtension: "wav") else {
            print("Could not find sound file for key: \(key)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch let error {
            print("Error loading audio for key \(key): \(error.localizedDescription)")
        }
    }
}
