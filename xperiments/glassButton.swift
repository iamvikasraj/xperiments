import SwiftUI

// MARK: - Main View
struct GlassButton: View {
    @State private var buttonLabel = "Count to 100?"
    @State private var progress: Int = 0
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 40) {
            AnimatedButton(text: buttonLabel) {
                guard !isAnimating else { return }
                isAnimating = true
                progress = 0
                animateProgress()
            }
            .scaleEffect(1.3)
            .buttonStyle(PlainButtonStyle())
            .shadow(radius: 4, x:12, y: 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AnimatedShaderBackground())
    }

    private func animateProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true) { timer in
            withAnimation(ButtonConfig.textSpringAnimation) {
                progress += 1
                buttonLabel = String(format: "%02d", progress)
            }

            if progress >= 100 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(ButtonConfig.springAnimation) {
                        buttonLabel = "Yayyyyyy!!!"
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(ButtonConfig.springAnimation) {
                        buttonLabel = "Once Again?"
                        isAnimating = false
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    GlassButton()
}
