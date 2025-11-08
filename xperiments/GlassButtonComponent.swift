//
//  GlassButtonComponent.swift
//  xperiments
//
//  Reusable Glass Button Component
//

import SwiftUI

// MARK: - Button Configuration
public struct ButtonConfig {
    public static let cornerRadius: CGFloat = 200
    public static let strokeWidth: CGFloat = 2
    public static let shadowRadius: CGFloat = 8
    public static let blurRadius: CGFloat = 8
    public static let pressedScale: CGFloat = 0.8
    public static let animationDuration: Double = 0.5
    
    // MARK: - Spring Animation Configuration
    public static let springResponse: Double = 0.5
    public static let springDampingFraction: Double = 0.55
    public static let springBlendDuration: Double = 0.3
    
    // Text/Content Animation (slightly different for smoother text transitions)
    public static let textSpringResponse: Double = 0.6
    public static let textSpringDampingFraction: Double = 0.65
    public static let textSpringBlendDuration: Double = 0.25
    
    // Background Color Animation
    public static let backgroundSpringResponse: Double = 0.4
    public static let backgroundSpringDampingFraction: Double = 0.75
    public static let backgroundSpringBlendDuration: Double = 0.15
    
    // MARK: - Pre-configured Animations
    public static var springAnimation: Animation {
        .spring(response: springResponse, dampingFraction: springDampingFraction, blendDuration: springBlendDuration)
    }
    
    public static var textSpringAnimation: Animation {
        .spring(response: textSpringResponse, dampingFraction: textSpringDampingFraction, blendDuration: textSpringBlendDuration)
    }
    
    public static var backgroundSpringAnimation: Animation {
        .spring(response: backgroundSpringResponse, dampingFraction: backgroundSpringDampingFraction, blendDuration: backgroundSpringBlendDuration)
    }
}

// MARK: - Stroke Gradients
let topbottom = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.white.opacity(0.9), location: 0.0),
        .init(color: Color.white.opacity(0.1), location: 0.4)
    ]),
    startPoint: .top,
    endPoint: .bottom
)

let bottomtop = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.white.opacity(0.7), location: 0.0),
        .init(color: Color.white.opacity(0.0), location: 0.3)
    ]),
    startPoint: .bottom,
    endPoint: .top
)

let leftotop = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.black.opacity(0.08), location: 0.0),
        .init(color: Color.black.opacity(0.0), location: 0.3)
    ]),
    startPoint: .leading,
    endPoint: .topTrailing
)

let rightotop = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.black.opacity(0.12), location: 0.0),
        .init(color: Color.black.opacity(0.0), location: 0.25)
    ]),
    startPoint: .trailing,
    endPoint: .topLeading
)

// MARK: - Custom Colors
extension Color {
    static let buttonFill = Color(red: 125/255, green: 135/255, blue: 140/255).opacity(0.00)
    static let glassyButtonFill = Color.black.opacity(1.0)
    
    static let frostedBackgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.9, green: 0.9, blue: 0.9),
            Color(red: 0.8, green: 0.82, blue: 0.85)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - AnimatedButton Component
public struct AnimatedButton: View {
    let text: String?
    let systemImageName: String?
    let cornerRadius: CGFloat
    let strokeWidth: CGFloat
    let showStroke: Bool
    let action: () -> Void

    @State private var isPressed = false

    public init(text: String, cornerRadius: CGFloat = ButtonConfig.cornerRadius, strokeWidth: CGFloat = ButtonConfig.strokeWidth, showStroke: Bool = true, action: @escaping () -> Void = {}) {
        self.text = text
        self.systemImageName = nil
        self.cornerRadius = cornerRadius
        self.strokeWidth = strokeWidth
        self.showStroke = showStroke
        self.action = action
    }
    
    public init(systemImageName: String, cornerRadius: CGFloat = ButtonConfig.cornerRadius, strokeWidth: CGFloat = ButtonConfig.strokeWidth, showStroke: Bool = true, action: @escaping () -> Void = {}) {
        self.text = nil
        self.systemImageName = systemImageName
        self.cornerRadius = cornerRadius
        self.strokeWidth = strokeWidth
        self.showStroke = showStroke
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let systemImageName = systemImageName {
                    Image(systemName: systemImageName)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.glassyButtonFill)
                        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                } else if let text = text {
                    Text(text)
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .foregroundColor(Color.glassyButtonFill)
                        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                        .contentTransition(.numericText(countsDown: false))
                        .animation(ButtonConfig.textSpringAnimation, value: text)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.buttonFill)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.buttonFill)
                            .blur(radius: ButtonConfig.blurRadius * 0.75)
                    )
                    .overlay(showStroke ? strokeOverlay : nil)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(color: .black.opacity(0.25), radius: isPressed ? 4 : ButtonConfig.shadowRadius, y: isPressed ? 8 : 12)
        .scaleEffect(isPressed ? ButtonConfig.pressedScale : 1)
        .animation(ButtonConfig.springAnimation, value: isPressed)
        .onPressGesture(
            pressing: { pressing in isPressed = pressing },
            perform: {}
        )
    }

    // MARK: - Stroke Overlay
    var strokeOverlay: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(leftotop, lineWidth: strokeWidth)
                .blendMode(.darken)

            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(rightotop, lineWidth: strokeWidth)
                .blendMode(.darken)

            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(bottomtop, lineWidth: strokeWidth)
                .blendMode(.overlay)

            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(topbottom, lineWidth: strokeWidth)
        }
    }
}

// MARK: - Press Gesture Extension
extension View {
    func onPressGesture(pressing: @escaping (Bool) -> Void, perform: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressing(true) }
                .onEnded { _ in
                    pressing(false)
                    perform()
                }
        )
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack(spacing: 40) {
            // Text Buttons
            VStack(spacing: 20) {
                Text("Text Buttons")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                AnimatedButton(text: "Click Me") {
                    print("Text button tapped")
                }
                
                AnimatedButton(text: "Hello") {
                    print("Hello button tapped")
                }
            }
            
            // SF Symbol Buttons
            VStack(spacing: 20) {
                Text("SF Symbol Buttons")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 20) {
                    AnimatedButton(systemImageName: "minus") {
                        print("Minus tapped")
                    }
                    
                    AnimatedButton(systemImageName: "plus") {
                        print("Plus tapped")
                    }
                }
                
                HStack(spacing: 20) {
                    AnimatedButton(systemImageName: "heart.fill") {
                        print("Heart tapped")
                    }
                    
                    AnimatedButton(systemImageName: "star.fill") {
                        print("Star tapped")
                    }
                }
            }
            
            // Mixed Examples
            VStack(spacing: 20) {
                Text("Mixed Examples")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                AnimatedButton(text: "Glass Button") {
                    print("Glass button tapped")
                }
                
                HStack(spacing: 20) {
                    AnimatedButton(systemImageName: "arrow.left") {
                        print("Left arrow tapped")
                    }
                    
                    AnimatedButton(systemImageName: "arrow.right") {
                        print("Right arrow tapped")
                    }
                }
                
                AnimatedButton(systemImageName: "play.fill") {
                    print("Play tapped")
                }
            }
        }
        .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.frostedBackgroundGradient)
    .ignoresSafeArea()
}
