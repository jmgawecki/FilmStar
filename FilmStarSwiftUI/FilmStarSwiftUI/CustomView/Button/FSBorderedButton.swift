import SwiftUI

struct FSBorederedButton: View {
    let title: String
    let systemImage: String
    let colour: Color
    let size: ControlSize
    var accessibilityLabel: String? = nil
    var accessibilityHint: String? = nil
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
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
