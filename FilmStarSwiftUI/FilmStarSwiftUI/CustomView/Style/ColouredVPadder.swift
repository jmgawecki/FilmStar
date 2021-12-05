import SwiftUI

struct ColouredVPadder<Content: View>: View {
    var backgroundColour: Color
    var cornerRadius: CGFloat
    var alignment: HorizontalAlignment = .center
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            backgroundColour
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding(.horizontal)
            HStack {
                VStack(alignment: alignment) {
                    content
                }
                Spacer()
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(12)
        }
    }
}

