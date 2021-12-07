import SwiftUI

struct ColouredVPadder<Content: View>: View {
    var backgroundColour: Color
    var cornerRadius: CGFloat
    var alignment: HorizontalAlignment = .center
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            backgroundColour
                .cornerRadius(15)
                .opacity(0.15)
            HStack {
                VStack(alignment: alignment) {
                    content
                        .foregroundColor(.purple)
                }
                Spacer()
            }
            .padding()
            .cornerRadius(12)
        }
    }
}

