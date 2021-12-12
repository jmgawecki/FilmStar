import SwiftUI

struct AROnboardingTab: View {
    @Binding var shouldPresentAROnboarding: Bool
    var body: some View {
        TabView {
            OnboardingPageView(
                title: AROnboarding.pageOneTitle,
                subtitle: AROnboarding.pageOneSubtitle,
                imageName: AROnboarding.pageOneImage
            )
            
            OnboardingPageView(
                title: AROnboarding.pageTwoTitle,
                subtitle: AROnboarding.pageTwoSubtitle,
                imageName: AROnboarding.pageTwoImage
            )
            
            OnboardingPageView(
                title: AROnboarding.pageThreeTitle,
                subtitle: AROnboarding.pageThreeSubtitle,
                imageName: AROnboarding.pageThreeImage
            )
            
            OnboardingPageView(
                title: AROnboarding.pageFourthTitle,
                subtitle: AROnboarding.pageFourthSubtitle,
                imageName: AROnboarding.pageFourthImage
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
                            .foregroundColor(.red)
                            .frame(width: 200, height: 200)
                    }
                    Text(AROnboarding.pageFifthTitle)
                        .font(Font.system(size: 30, weight: .bold, design: .rounded))
                        .padding(.vertical)
                    
                    Text(AROnboarding.pageFifthSubtitle)
                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
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
