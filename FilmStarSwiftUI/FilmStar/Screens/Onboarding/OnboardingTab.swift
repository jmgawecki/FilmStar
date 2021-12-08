import SwiftUI

struct OnboardingTab: View {
    @Binding var shouldPresentOnboarding: Bool
    var body: some View {
        TabView {
            OnboardingPageView(
                title: Onboarding.pageOneTitle,
                subtitle: Onboarding.pageOneSubtitle,
                imageName: Onboarding.pageOneImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: Onboarding.pageTwoTitle,
                subtitle: Onboarding.pageTwoSubtitle,
                imageName: Onboarding.pageTwoImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: Onboarding.pageThreeTitle,
                subtitle: Onboarding.pageThreeSubtitle,
                imageName: Onboarding.pageThreeImage,
                showsDismissButton: true,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct OnboardingScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTab(shouldPresentOnboarding: .constant(true))
    }
}

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
