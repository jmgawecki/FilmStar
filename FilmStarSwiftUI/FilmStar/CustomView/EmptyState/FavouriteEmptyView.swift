import SwiftUI

/// FavouriteEmptyState provides visual experience when user has no film in his list of favourites
///
/// Struct observes `RotationAnimationManager` and animates its icon back and forward
///
/// Please go to `RotationAnimationManager` to understand how it works.
struct FavouriteEmptyView: View {
    @ObservedObject private var animationManager = RotationAnimationManager()
    @AccessibilityFocusState var isScreenFocused: Bool
    
    var body: some View {
        VStack {
            Image(systemName: SFSymbol.notFavourite)
                .resizable()
                .scaledToFit()
                .foregroundColor(.purple)
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(animationManager.rotationAngle))
                .animation(.easeInOut(duration: 2.5), value: animationManager.rotationAngle)
                .accessibilityHidden(true)
                .accessibilityIdentifier("animatingFavouritesImage")
            VStack(alignment: .leading) {
                Text(Description.yourFavouritesAreEmpty)
                    .font(Font.system(size: 50, weight: .bold, design: .rounded))
                    .padding(.top)
                
                Text(Description.addSomeFavourites)
                    .font(Font.system(size: 25, weight: .semibold, design: .rounded))
            }
            .contentShape(Rectangle())
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(VoiceOver.yourFavouritesAreEmpty)
            .accessibilityHint(VoiceOver.goBackToSearchScreenHint)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)
            .accessibilityFocused($isScreenFocused)
            .accessibilitySortPriority(10)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isScreenFocused = true
            }
        }
    }
}

struct FavouriteEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEmptyView()
    }
}
