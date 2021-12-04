import SwiftUI

struct FSProminentButton: View {
    let title: String
    let systemImage: String
    let colour: Color
    let size: ControlSize
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
            Text(title)
        }
        .buttonStyle(.borderedProminent)
        .tint(colour)
        .controlSize(size)
    }
}
