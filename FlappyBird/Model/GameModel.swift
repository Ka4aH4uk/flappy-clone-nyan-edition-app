//
//  GameModel.swift
//  FlappyBird
//
//  Created by K4 on 13.11.2023.
//

import SwiftUI
import Combine

enum GameState {
    case ready, active, stopped, menu
}

enum Difficulty: String, CaseIterable {
    case easy
    case normal
    case hardcore
    
    enum Level: String {
        case easy = "Easy"
        case normal = "Normal"
        case hardcore = "Hardcore"
    }

    var flagOffset: (x: CGFloat, y: CGFloat) {
        switch self {
        case .easy: 
            (x: -11, y: -45)
        case .normal:
            (x: -25, y: 0)
        case .hardcore:
            (x: -40, y: 43)
        }
    }
}

enum SoundKey: String {
    case nyan = "nyan"
    case hit = "hit"
    case die = "die"
    case wav = "wav"
}

struct GameModel {
    @AppStorage("highScore") var highScore: Int = 0
    var birdVelocity: CGVector
    var birdPosition: CGPoint
    let birdSize: CGFloat
    var birdRadius: CGFloat
    var pipeSpacing: CGFloat
    var pipeOffset: CGFloat
    var topPipeHeight: CGFloat
    let pipeWidth: CGFloat
    var passedPipe: Bool
    var gameState: GameState
    var difficulty: Difficulty
    var lastUpdateTime: Date
    var scores: Int
    var gravity: CGFloat
    var groundHeight: CGFloat
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>
}
