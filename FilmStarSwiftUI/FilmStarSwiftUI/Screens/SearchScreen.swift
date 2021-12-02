import SwiftUI

struct SearchScreen: View {
    @State private var searchText = ""
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                
                ZStack {
                    Rectangle()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                    .padding(.bottom)
                    Text("LOGO")
                        .font(.title)
                        .foregroundColor(Color.purple)
                        .tint(Color.blue)
                }
                
                TextField("Search for film..", text: $searchText)
                    .frame(width: 300, height: 44)
                    .padding(.horizontal)
                    .overlay(Capsule(style: .continuous)
                                .stroke(Color.purple, lineWidth: 1))
                Button {
                    print("Ive been tapped")
                } label: {
                    Image(systemName: SFSymbol.film)
                    Text("Search")
                }
                
                .buttonStyle(.bordered)
                .tint(.purple)
                .controlSize(.large)
                
                Rectangle()
                    .frame(
                        width: UIScreen.main.bounds.size.width - 50,
                        height: UIScreen.main.bounds.size.height * 0.40 )
                    .cornerRadius(20)
            }
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
