//
//  StartViewModel.swift
//  FlappyBird
//
//  Created by K4 on 13.11.2023.
//

import SwiftUI

class StartViewModel: ObservableObject {
    @Published var data: StartModel
    
    init() {
        self.data = StartModel(isAnimatedScale: false, shouldStartGame: false)
    }
    
    func startGame() {
        data.shouldStartGame.toggle()
    }
}
