import SwiftUI

@main
struct FilmStarSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .systemBackground
    }

    var body: some Scene {
        WindowGroup {
            TabViewScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
