//
//  GlassButtonSingle.swift
//  xperiments
//
//  Single Glass Button with SF Symbol
//

import SwiftUI

struct GlassButtonSingle: View {
    @State private var isOn = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(ButtonConfig.springAnimation) {
                    isOn.toggle()
                }
                print("Button tapped - \(isOn ? "on" : "off")")
            }) {
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.glassyButtonFill)
                    .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                    .symbolEffect(.bounce, value: isOn)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius)
                            .fill(Color.buttonFill)
                            .background(
                                RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius)
                                    .fill(Color.buttonFill)
                                    .blur(radius: ButtonConfig.blurRadius * 0.75)
                            )
                            .overlay(strokeOverlay)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius))
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius))
            .shadow(color: .black.opacity(0.25), radius: ButtonConfig.shadowRadius, y: 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AnimatedShaderBackground())
        .ignoresSafeArea()
    }
    
    // MARK: - Stroke Overlay
    var strokeOverlay: some View {
        ZStack {
            RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius)
                .stroke(leftotop, lineWidth: ButtonConfig.strokeWidth)
                .blendMode(.darken)

            RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius)
                .stroke(rightotop, lineWidth: ButtonConfig.strokeWidth)
                .blendMode(.darken)

            RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius)
                .stroke(bottomtop, lineWidth: ButtonConfig.strokeWidth)
                .blendMode(.overlay)

            RoundedRectangle(cornerRadius: ButtonConfig.cornerRadius)
                .stroke(topbottom, lineWidth: ButtonConfig.strokeWidth)
        }
    }
}

#Preview {
    GlassButtonSingle()
}

