//
//  SettingsView.swift
//  FlappyBird
//
//  Created by K4 on 13.11.2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Tune")
                    .font(.title).bold()
                    .fontDesign(.monospaced)
                    .padding(.trailing, 20)
                Button {
                    viewModel.toggleSound()
                } label: {
                    Image(systemName: viewModel.isSoundEnabled ? "speaker.wave.3" : "speaker.slash")
                        .font(Font.system(size: 30))
                        .foregroundStyle(viewModel.isSoundEnabled ? .green : .red)
                        .shadow(radius: 1)
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.top, 5).padding(.bottom)
            
            Text("Difficulty")
                .font(.title).bold()
                .padding(.horizontal)
            
            ZStack(alignment: .leading) {
                VStack {
                    Group {
                        Button(action: {
                            viewModel.updateDifficulty(.easy)
                        }, label: {
                            Text(Difficulty.Level.easy.rawValue)
                        })
                        .foregroundStyle(.yellow.gradient)
                        
                        Button(action: {
                            viewModel.updateDifficulty(.normal)
                        }, label: {
                            Text(Difficulty.Level.normal.rawValue)
                        })
                        .foregroundStyle(.orange.gradient)
                        
                        Button(action: {
                            viewModel.updateDifficulty(.hardcore)
                        }, label: {
                            Text(Difficulty.Level.hardcore.rawValue)
                        })
                        .foregroundStyle(.red.gradient)
                    }
                    .font(.title2).bold()
                    .padding(.vertical, 5)
                    .shadow(radius: 1)
                }
                
                // Добавляем указатель слева от выбранного уровня сложности
                if let difficulty = Difficulty(rawValue: viewModel.gameModel.difficulty.rawValue) {
                    Image(.flappyFlag)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .offset(x: difficulty.flagOffset.x, y: difficulty.flagOffset.y)
                }
            }
            
            Button(action: {
                viewModel.resumeGame()
            }, label: {
                Image(systemName: "arrow.uturn.backward")
                    .font(Font.system(size: 30)).bold()
                    .foregroundStyle(.black)
            })
            .padding(.top, 5).padding(.bottom, 10)
        }
        .padding()
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
        
        SettingsView(viewModel: GameViewModel())
    }
}

