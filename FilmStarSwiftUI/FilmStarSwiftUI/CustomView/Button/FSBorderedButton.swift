import SwiftUI

struct FSBorederedButton: View {
    let title: String
    let systemImage: String
    let colour: Color
    let size: ControlSize
    var isAnimated: Bool = false
    var accessibilityLabel: String? = nil
    var accessibilityHint: String? = nil
    @State private var animationAngle: Double = 0
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
            if isAnimated {
                animationAngle += 360
            }
        }) {
            Image(systemName: systemImage)
                .rotationEffect(.degrees(animationAngle))
                .animation(.easeIn, value: animationAngle)
            Text(title)
        }
        .buttonStyle(.bordered)
        .tint(colour)
        .controlSize(size)
        .accessibilityLabel(Text(accessibilityLabel ?? title))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(accessibilityHint ?? "")
    }
}

