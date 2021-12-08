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
                .accessibilityElement(children: .ignore)
                .clipShape(Rectangle())
                .accessibilityLabel("Search for your favourite film or films with the title or with the IMDb I D")
            
            if PosterARView.isARExperienceAvailable {
                OnboardingPageView(
                    title: Onboarding.pageTwoTitle,
                    subtitle: Onboarding.pageTwoSubtitle,
                    imageName: Onboarding.pageTwoImage,
                    showsDismissButton: false,
                    shouldPresentOnboarding: $shouldPresentOnboarding
                )
                    .accessibilityElement(children: .ignore)
                    .clipShape(Rectangle())
                    .accessibilityLabel("Add found films to your favourites list and check those you have recently searched for.")
                
                OnboardingPageLastView(
                    title: Onboarding.pageThreeTitle,
                    subtitle: Onboarding.pageThreeSubtitle,
                    imageName: Onboarding.pageThreeImage,
                    accessibilityLabel: "AR Experience description",
                    accessibilityHint: VoiceOver.arExperienceNotFriendlyHint,
                    shouldPresentOnboarding: $shouldPresentOnboarding
                )
            } else {
                OnboardingPageLastView(
                    title: Onboarding.pageTwoTitle,
                    subtitle: Onboarding.pageTwoSubtitle,
                    imageName: Onboarding.pageTwoImage,
                    accessibilityLabel: "Add found films to your favourites list and check those you have recently searched for.",
                    shouldPresentOnboarding: $shouldPresentOnboarding
                )
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct OnboardingScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTab(shouldPresentOnboarding: .constant(true))
    }
}

fileprivate struct OnboardingPageLastView: View {
    var title: String
    var subtitle: String
    var imageName: String
    var accessibilityLabel: String
    var accessibilityHint: String? = nil
    @Binding var shouldPresentOnboarding: Bool
    
    var body: some View {
        ZStack {
            VStack {
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
                }
                .accessibilityElement(children: .ignore)
                .clipShape(Rectangle())
                .accessibilityLabel(accessibilityLabel)
                .accessibilityHint(accessibilityHint ?? "")
                
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
