import SwiftUI
/**
Modern style button.

`FSBorederedButton` allows image to be animated upon the tap gesture
 
To manipulate button's Style, please use `.buttonStyle()` as such:
 
 ```Swift
 FSButton(
     title: Description.gotIt,
     systemImage: SFSymbol.checkmark,
     colour: .purple,
     size: .large,
     accessibilityHint: VoiceOver.doubleTapToCloseOnboarding) {
         shouldPresentOnboarding.toggle()
     }
     .buttonStyle(.bordered)
 ```

Accessibility can be easily applied by providing strings within the initialiser respective parameters.
*/
struct FSButton: View {
    var title: String? = nil
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
            if let title = title {
                Text(title)
            }
        }
        .tint(colour)
        .controlSize(size)
        .accessibilityLabel(Text(accessibilityLabel ?? title ?? ""))
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(accessibilityHint ?? "")
    }
}

