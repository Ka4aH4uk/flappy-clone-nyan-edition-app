//
//  ResultView.swift
//  FlappyBird
//
//  Created by K4 on 06.11.2023.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    let highScore: Int
    let resetAction: () -> Void
    private let gameOverHeight: CGFloat = 60
    private let buttonResetHeight: CGFloat = 50
    
    var body: some View {
        VStack {
            Image(.flappyGameOver)
                .resizable()
                .scaledToFit()
                .frame(height: gameOverHeight)
                .padding(.horizontal).padding(.top)
            Text("Score: \(score)")
                .font(.title)
                .padding(.bottom, 5)
            HStack {
                Image(.flappyBestResult)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Text("\(highScore)")
                    .font(.title)
            }
            Button(action: resetAction, label: {
                Image(.flappyButtonReset)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: buttonResetHeight)
            })
            .shadow(radius: 4)
            .padding(.bottom)
        }
        .fontDesign(.monospaced)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
        )
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 10, x: 2, y: 2)
        .padding()
    }
}

#Preview {
    ZStack {
        Image(.flappyBackground)
            .resizable()
            .ignoresSafeArea()
        
        ResultView(score: 3, highScore: 5, resetAction: {})
    }
}
