//
//  glassCounter.swift
//  xperiments
//
//  Created by Vikas Raj Yadav on 26/07/25.
//

import SwiftUI

struct glassCounter: View {
    @State private var count: Int = 0
    
    var body: some View {
        VStack(spacing: 40) {
            // Counter Display
            
            
            // Buttons Row
            HStack(spacing: 30) {
                // Minus Button
                AnimatedButton(systemImageName: "minus") {
                    withAnimation(ButtonConfig.springAnimation) {
                        count -= 1
                    }
                }
                .frame(width: 80, height: 80)
                .scaleEffect(1.0)
                .buttonStyle(PlainButtonStyle())
                
                Text("\(count)")
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .foregroundColor(Color.glassyButtonFill)
                    .shadow(color: .black.opacity(0.1), radius: 2, y: 2)
                    .contentTransition(.numericText(countsDown: false))
                    .animation(ButtonConfig.textSpringAnimation, value: count)
                    .padding(.vertical, 20)
                
                // Plus Button
                AnimatedButton(systemImageName: "plus") {
                    withAnimation(ButtonConfig.springAnimation) {
                        count += 1
                    }
                }
                .frame(width: 80, height: 80)
                .scaleEffect(1.0)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.frostedBackgroundGradient)
    }
}

#Preview {
    glassCounter()
}
