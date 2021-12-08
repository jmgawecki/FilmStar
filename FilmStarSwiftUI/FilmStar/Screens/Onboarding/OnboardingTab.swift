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
            
            if PosterARView.isARExperienceAvailable {
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
            } else {
                OnboardingPageView(
                    title: Onboarding.pageTwoTitle,
                    subtitle: Onboarding.pageTwoSubtitle,
                    imageName: Onboarding.pageTwoImage,
                    showsDismissButton: true,
                    shouldPresentOnboarding: $shouldPresentOnboarding
                )
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct OnboardingScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTab(shouldPresentOnboarding: .constant(true))
    }
}
