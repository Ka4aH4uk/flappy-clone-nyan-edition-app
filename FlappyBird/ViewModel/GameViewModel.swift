//
//  GameViewModel.swift
//  FlappyBird
//
//  Created by K4 on 13.11.2023.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameModel: GameModel
    @AppStorage("isSoundEnabled") var isSoundEnabled = true
    
    let soundService = SoundService()

    init() {
        self.gameModel = GameModel(
            birdVelocity: CGVector(dx: 0, dy: 0),
            birdPosition: CGPoint(x: 100, y: 350),
            birdSize: 80,
            birdRadius: 13,
            pipeSpacing: 150,
            pipeOffset: 0,
            topPipeHeight: CGFloat.random(in: 100...500),
            pipeWidth: 100,
            passedPipe: false,
            gameState: .ready,
            difficulty: .normal, 
            lastUpdateTime: Date(),
            scores: 0,
            gravity: 1000,
            groundHeight: 100,
            timer: Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        )
    }

    func playButtonAction() {
        if gameModel.gameState == .ready {
            gameModel.gameState = .active
            gameModel.lastUpdateTime = Date()
            
            if isSoundEnabled {
                soundService.playSound(key: SoundKey.nyan.rawValue)
            }
        }
    }
    
    
    func settingsButtonTapped() {
        gameModel.gameState = .menu
    }
    
    func resumeGame() {
        if gameModel.gameState == .menu  {
            gameModel.gameState = .ready
        }
    }
    
    func updateDifficulty(_ difficulty: Difficulty) {
        gameModel.difficulty = difficulty
        switch difficulty {
        case .easy:
            gameModel.pipeSpacing = 200
        case .normal:
            gameModel.pipeSpacing = 150
        case .hardcore:
            gameModel.pipeSpacing = 100
        }
    }

    func applyGravity(deltaTime: TimeInterval) {
        gameModel.birdVelocity.dy += CGFloat(gameModel.gravity * deltaTime)
    }

    func updateBirdPosition(deltaTime: TimeInterval, geometry: GeometryProxy) {
        gameModel.birdPosition.y += gameModel.birdVelocity.dy * CGFloat(deltaTime)
    }

    func checkBoundaries(geometry: GeometryProxy) {
        // Проверка, не достигла ли птица верхней границы экрана
        if gameModel.birdPosition.y <= 0 {
            gameModel.birdPosition.y = 0
            gameModel.gameState = .stopped
            
            if isSoundEnabled {
                soundService.playSound(key: SoundKey.die.rawValue)
            }
        }

        // Проверка, не достигла ли птица грунта
        if gameModel.birdPosition.y > geometry.size.height - gameModel.groundHeight {
            gameModel.birdPosition.y = geometry.size.height - gameModel.groundHeight
            gameModel.birdVelocity.dy = 0
            gameModel.gameState = .stopped
            
            if isSoundEnabled {
                soundService.playSound(key: SoundKey.die.rawValue)
            }
        }
    }

    func updatePipePosition(deltaTime: TimeInterval) {
        gameModel.pipeOffset -= CGFloat(300 * deltaTime)
    }

    func resetPipePositionIfNeeded(geometry: GeometryProxy) {
        if gameModel.pipeOffset <= -geometry.size.width - gameModel.pipeWidth {
            gameModel.pipeOffset = 0
            gameModel.topPipeHeight = CGFloat.random(in: 100...500)
        }
    }

    func checkCollisions(geometry: GeometryProxy) -> Bool {
        // Создаем прямоугольник вокруг птицы
        let birdFrame = CGRect(
            x: gameModel.birdPosition.x - gameModel.birdRadius / 2,
            y: gameModel.birdPosition.y - gameModel.birdRadius / 2,
            width: gameModel.birdRadius,
            height: gameModel.birdRadius
        )
        
        // Создаем прямоугольник вокруг верхнего столба
        let topPipeFrame = CGRect(
            x: geometry.size.width + gameModel.pipeOffset,
            y: 0,
            width: gameModel.pipeWidth,
            height: gameModel.topPipeHeight
        )
        
        // Создаем прямоугольник вокруг нижнего столба
        let bottomPipeFrame = CGRect(
            x: geometry.size.width + gameModel.pipeOffset,
            y: gameModel.topPipeHeight + gameModel.pipeSpacing,
            width: gameModel.pipeWidth,
            height: gameModel.topPipeHeight
        )

        return birdFrame.intersects(topPipeFrame) || birdFrame.intersects(bottomPipeFrame)
    }

    func updateScores(geometry: GeometryProxy) {
        if (gameModel.pipeOffset + gameModel.pipeWidth + geometry.size.width) < gameModel.birdPosition.x && !gameModel.passedPipe {
            gameModel.scores += 1

            if gameModel.scores > gameModel.highScore {
                gameModel.highScore = gameModel.scores
            }

            gameModel.passedPipe = true
        } else if gameModel.pipeOffset + geometry.size.width > gameModel.birdPosition.x {
            gameModel.passedPipe = false
        }
    }

    func resetGame() {
        gameModel.birdPosition = CGPoint(x: 100, y: 350)
        gameModel.birdVelocity = CGVector(dx: 0, dy: 0)
        gameModel.pipeOffset = 0
        gameModel.topPipeHeight = CGFloat.random(in: 100...500)
        gameModel.scores = 0
        gameModel.gameState = .ready
    }
    
    func toggleSound() {
        isSoundEnabled.toggle()
        if !isSoundEnabled {
            soundService.audioPlayer?.stop()
        }
    }
}
