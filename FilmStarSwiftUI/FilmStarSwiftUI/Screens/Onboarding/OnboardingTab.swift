import SwiftUI

struct OnboardingTab: View {
    @Binding var shouldPresentOnboarding: Bool
    var body: some View {
        TabView {
            OnboardingPageView(
                title: "Search for your favourite films",
                subtitle: "Search with the title or search with the IMDb ID",
                imageName: "mail.and.text.magnifyingglass",
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: "Add films to your favourites",
                subtitle: "And check those that you've recently searched for",
                imageName: "star.fill",
                showsDismissButton: false,
                shouldPresentOnboarding: $shouldPresentOnboarding
            )
            
            OnboardingPageView(
                title: "Go through an exciting AR experience!",
                subtitle: "See how the film's poster will fit above the sofa",
                imageName: "arkit",
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
                        title: "Got it!",
                        systemImage: "checkmark",
                        colour: .purple,
                        size: .large,
                        accessibilityHint: "Double tab to close onboarding screens.") {
                            shouldPresentOnboarding.toggle()
                        }
                }
            }
        }
    }
}
