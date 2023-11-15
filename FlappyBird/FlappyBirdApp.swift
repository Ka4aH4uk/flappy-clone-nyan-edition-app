//
//  FlappyBirdApp.swift
//  FlappyBird
//
//  Created by K4 on 06.11.2023.
//

import SwiftUI

@main
struct FlappyBirdApp: App {
    @StateObject private var startViewModel = StartViewModel()
    @StateObject private var gameViewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
            if startViewModel.data.shouldStartGame {
                GameView(viewModel: gameViewModel)
            } else {
                StartView(viewModel: startViewModel)
            }
        }
    }
}
