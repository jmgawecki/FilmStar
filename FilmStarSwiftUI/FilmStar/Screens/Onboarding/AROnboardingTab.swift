import SwiftUI

struct AROnboardingTab: View {
    @Binding var shouldPresentOnboarding: Bool
    var body: some View {
        TabView {
            OnboardingPageView(
                title: AROnboarding.pageOneTitle,
                subtitle: AROnboarding.pageOneSubtitle,
                imageName: AROnboarding.pageOneImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: AROnboarding.pageTwoTitle,
                subtitle: AROnboarding.pageTwoSubtitle,
                imageName: AROnboarding.pageTwoImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: AROnboarding.pageThreeTitle,
                subtitle: AROnboarding.pageThreeSubtitle,
                imageName: AROnboarding.pageThreeImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: AROnboarding.pageFourthTitle,
                subtitle: AROnboarding.pageFourthSubtitle,
                imageName: AROnboarding.pageFourthImage,
                showsDismissButton: true,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct AROnboardingScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        AROnboardingTab(shouldPresentOnboarding: .constant(true))
    }
}
