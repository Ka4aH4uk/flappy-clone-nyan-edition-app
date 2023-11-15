//
//  GameScoreToolbarView.swift
//  FlappyBird
//
//  Created by K4 on 15.11.2023.
//

import SwiftUI

struct GameScoreToolbarView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        if viewModel.gameModel.gameState == .active {
            
            HStack {
                Image(.flappyPipe)
                    .resizable()
                    .frame(width: 20, height: 30)
                    .padding(.trailing, 5)
                Spacer()
                Text(viewModel.gameModel.scores.formatted())
                    .fontDesign(.monospaced)
                    .foregroundStyle(.white)
                    .font(.largeTitle).bold()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .frame(width: 100)
            .background {
                Rectangle()
                    .foregroundStyle(.orange.gradient)
                    .cornerRadius(12)
            }
        } else {
            Text("")
        }
    }
}

#Preview {
    GameScoreToolbarView(viewModel: GameViewModel())
}
