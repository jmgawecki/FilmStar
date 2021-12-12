import SwiftUI

struct OnboardingPageView: View {
    var title: String
    var subtitle: String
    var imageName: String
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(Font.system(size: 40, weight: .bold, design: .rounded))
                        .padding(.vertical)
                    
                    Text(subtitle)
                        .font(Font.system(size: 15, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.4)
                        .foregroundColor(.purple)
                        .padding(.vertical)
                }
            }
        }
    }
}
