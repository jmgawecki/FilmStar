import SwiftUI

struct OnboardingPageView: View {
    var title: String
    var subtitle: String
    var imageName: String
    var showsDismissButton: Bool
    @Binding var shouldPresentOnboarding: Bool
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text(title)
                    .font(.title2)
                    .padding(.vertical)
                
                Text(subtitle)
                    .foregroundColor(.purple)
                    .padding(.bottom)
                
                if showsDismissButton {
                    FSBorederedButton(
                        title: Description.gotIt,
                        systemImage: SFSymbol.checkmark,
                        colour: .purple,
                        size: .large,
                        accessibilityHint: VoiceOver.doubleTapToCloseOnboarding) {
                            shouldPresentOnboarding.toggle()
                        }
                }
            }
        }
    }
}
