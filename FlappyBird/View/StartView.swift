//
//  StartView.swift
//  FlappyBird
//
//  Created by K4 on 07.11.2023.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var viewModel: StartViewModel
    
    var body: some View {
        ZStack {
            Image(.flappyBackground)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image(.flappyLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: viewModel.data.logoHeight)
                
                Spacer()
                    .frame(height: 40)
                
                Image(.flappyTap)
                    .resizable()
                    .scaledToFit()
                    .frame(height: viewModel.data.tapImageHeight)
                    .scaleEffect(viewModel.data.isAnimatedScale ? 1.0 : 0.8)
                    .animation(viewModel.data.animation, value: viewModel.data.isAnimatedScale)
                    .padding()
            }
        }
        .onTapGesture {
            viewModel.startGame()
        }
        .onAppear {
            viewModel.data.isAnimatedScale.toggle()
        }
    }
}

#Preview {
    StartView(viewModel: StartViewModel())
}
