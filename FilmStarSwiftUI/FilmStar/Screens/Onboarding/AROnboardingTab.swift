import SwiftUI

struct AROnboardingTab: View {
    @Binding var shouldPresentAROnboarding: Bool
    var body: some View {
        TabView {
            OnboardingPageView(
                title: AROnboarding.pageOneTitle,
                subtitle: AROnboarding.pageOneSubtitle,
                imageName: AROnboarding.pageOneImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentAROnboarding
            )
            
            OnboardingPageView(
                title: AROnboarding.pageTwoTitle,
                subtitle: AROnboarding.pageTwoSubtitle,
                imageName: AROnboarding.pageTwoImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentAROnboarding
            )
            
            OnboardingPageView(
                title: AROnboarding.pageThreeTitle,
                subtitle: AROnboarding.pageThreeSubtitle,
                imageName: AROnboarding.pageThreeImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentAROnboarding
            )
            
            OnboardingPageView(
                title: AROnboarding.pageFourthTitle,
                subtitle: AROnboarding.pageFourthSubtitle,
                imageName: AROnboarding.pageFourthImage,
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentAROnboarding
            )
            
            ZStack {
                VStack {
                    ZStack {
                        Image(systemName: AROnboarding.pageFifthImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Image(systemName: AROnboarding.pageFifthImageCross)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                    Text(AROnboarding.pageFifthTitle)
                        .font(.title2)
                        .padding(.vertical)
                    
                    Text(AROnboarding.pageFifthSubtitle)
                        .foregroundColor(.purple)
                        .padding(.bottom)
                    
                    
                    FSBorederedButton(
                        title: Description.gotIt,
                        systemImage: SFSymbol.checkmark,
                        colour: .purple,
                        size: .large,
                        accessibilityHint: VoiceOver.doubleTapToCloseOnboarding) {
                            shouldPresentAROnboarding.toggle()
                        }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct AROnboardingScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        AROnboardingTab(shouldPresentAROnboarding: .constant(true))
    }
}
