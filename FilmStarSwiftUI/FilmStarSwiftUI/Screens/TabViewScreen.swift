import SwiftUI

struct TabViewScreen: View {
    var body: some View {
        TabView {
            Text("Search")
                .tabItem {
                    Text("Search")
                    Image(systemName: SFSymbol.search)
                }
                
            Text("Favourites")
                .tabItem {
                    Text("Favourites")
                    Image(systemName: SFSymbol.favourites)
                }
        }
        .accentColor(Color.purple)
    }
}

struct TabViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabViewScreen()
    }
}
