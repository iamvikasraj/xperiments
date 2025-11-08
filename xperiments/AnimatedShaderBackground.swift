//
//  AnimatedShaderBackground.swift
//  xperiments
//
//  Animated Shader Material Background Component
//

import SwiftUI

public struct AnimatedShaderBackground: View {
    @State private var colorPhase: CGFloat = 0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Animated gradient shader with color changes
            LinearGradient(
                gradient: Gradient(colors: animatedColors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blur(radius: 80)
            .brightness(0.1)
            
            // Additional radial gradient for glow effect
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.95, blue: 0.8).opacity(0.4),
                    Color(red: 1.0, green: 0.85, blue: 0.6).opacity(0.2),
                    Color.clear
                ]),
                center: .topLeading,
                startRadius: 100,
                endRadius: 400
            )
            .blur(radius: 60)
        }
        .onAppear {
            startAnimation()
        }
    }
    
    // MARK: - Animated Colors (Warm yellows, oranges, light blues)
    private var animatedColors: [Color] {
        let phase1 = sin(colorPhase) * 0.5 + 0.5
        let phase2 = sin(colorPhase + .pi * 2/3) * 0.5 + 0.5
        let phase3 = sin(colorPhase + .pi * 4/3) * 0.5 + 0.5
        
        // Warm palette: pale yellow, sunny yellow, coral/orange, light blue
        return [
            // Pale yellow to sunny yellow
            Color(red: 1.0, green: 0.98 + phase1 * 0.02, blue: 0.9 + phase2 * 0.05),
            // Sunny yellow to warm orange
            Color(red: 1.0, green: 0.85 + phase2 * 0.1, blue: 0.6 + phase3 * 0.2),
            // Coral/orange
            Color(red: 1.0, green: 0.7 + phase3 * 0.15, blue: 0.5 + phase1 * 0.2),
            // Light blue/cyan
            Color(red: 0.9 + phase1 * 0.1, green: 0.95 + phase2 * 0.05, blue: 1.0)
        ]
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            withAnimation(ButtonConfig.backgroundSpringAnimation) {
                colorPhase += 0.05
                if colorPhase > .pi * 2 {
                    colorPhase = 0
                }
            }
        }
    }
}

#Preview {
    AnimatedShaderBackground()
        .ignoresSafeArea()
}

