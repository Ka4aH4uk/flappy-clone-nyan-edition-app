//
//  StartModel.swift
//  FlappyBird
//
//  Created by K4 on 13.11.2023.
//

import SwiftUI

struct StartModel {
    var isAnimatedScale: Bool
    var shouldStartGame: Bool
    let logoHeight: CGFloat = 80
    let tapImageHeight: CGFloat = 150

    var animation: Animation {
        Animation.spring(response: 0.9, dampingFraction: 0.7)
            .repeatForever(autoreverses: false)
    }
}
