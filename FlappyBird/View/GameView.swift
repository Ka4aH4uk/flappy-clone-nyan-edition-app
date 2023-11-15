//
//  ContentView.swift
//  FlappyBird
//
//  Created by K4 on 06.11.2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Image(.flappyBackground)
                        .resizable()
                        .ignoresSafeArea()
                        .blur(radius: viewModel.gameModel.gameState == .menu ? 3.0 : 0.0)
                    
                    if viewModel.gameModel.gameState != .menu {
                        BirdView(birdSize: viewModel.gameModel.birdSize)
                            .position(viewModel.gameModel.birdPosition)
                    }
                    
                    PipeView(
                        topPipeHeight: viewModel.gameModel.topPipeHeight,
                        pipeWidth: viewModel.gameModel.pipeWidth,
                        pipeSpacing: viewModel.gameModel.pipeSpacing
                    )
                    .offset(x: geometry.size.width + viewModel.gameModel.pipeOffset)
                    
                    if viewModel.gameModel.gameState == .ready {
                        VStack {
                            VStack {
                                Spacer()
                                Image(.flappyGetReady)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                    .padding(.bottom)
                                Spacer()
                            }
                            VStack {
                                Button(action: viewModel.playButtonAction) {
                                    Image(systemName: "play.fill")
                                }
                                .font(Font.system(size: 80))
                                .foregroundStyle(.blue.gradient)
                                .shadow(color: .white, radius: 6, x: 0, y: 0)
                                .padding(.bottom)
                                
                                Button(action: viewModel.settingsButtonTapped) {
                                    Image(.flappyMenu)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 60)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                    if viewModel.gameModel.gameState == .stopped {
                        ResultView(score: viewModel.gameModel.scores, highScore: viewModel.gameModel.highScore) {
                            viewModel.resetGame()
                        }
                    }
                    
                    if viewModel.gameModel.gameState == .menu {
                        SettingsView(viewModel: viewModel)
                    }
                }
                .onTapGesture {
                    // Устанавливаем вертикальную скорость в верх
                    viewModel.gameModel.birdVelocity = CGVector(dx: 0, dy: -400)
                }
                .onReceive(viewModel.gameModel.timer) { currentTime in
                    guard viewModel.gameModel.gameState == .active else { return }
                    let deltaTime = currentTime.timeIntervalSince(viewModel.gameModel.lastUpdateTime)
                    
                    viewModel.applyGravity(deltaTime: deltaTime)
                    viewModel.updateBirdPosition(deltaTime: deltaTime, geometry: geometry)
                    viewModel.checkBoundaries(geometry: geometry)
                    viewModel.updatePipePosition(deltaTime: deltaTime)
                    viewModel.resetPipePositionIfNeeded(geometry: geometry)
                    
                    if viewModel.checkCollisions(
                        geometry: geometry
                    ) {
                        if viewModel.isSoundEnabled {
                            viewModel.soundService.playSound(key: SoundKey.hit.rawValue)
                        }
                        viewModel.gameModel.gameState = .stopped
                    }
                    
                    viewModel.updateScores(geometry: geometry)
                    
                    viewModel.gameModel.lastUpdateTime = currentTime
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        GameScoreToolbarView(viewModel: viewModel)
                    }
                }
            }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}
