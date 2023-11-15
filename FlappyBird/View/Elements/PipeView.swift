//
//  PipeView.swift
//  FlappyBird
//
//  Created by K4 on 06.11.2023.
//

import SwiftUI

struct PipeView: View {
    let topPipeHeight: CGFloat
    let pipeWidth: CGFloat
    let pipeSpacing: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let availableHeight = geometry.size.height - pipeSpacing
            let bottomPipeHeight = availableHeight - topPipeHeight
            
            VStack {
                // Top Pipe
                Image(.flappyPipe)
                    .resizable()
                    .rotationEffect(.degrees(180))
                    .frame(width: pipeWidth, height: topPipeHeight)
                
                Spacer()
                    .frame(height: pipeSpacing)
                
                // Bottom Pipe
                Image(.flappyPipe)
                    .resizable()
                    .frame(width: pipeWidth, height: abs(bottomPipeHeight))
            }
        }
    }
}

#Preview {
    PipeView(topPipeHeight: 300, pipeWidth: 100, pipeSpacing: 150)
}
