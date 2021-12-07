import SwiftUI

@main
struct FilmStarSwiftUIApp: App {
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .systemBackground
    }

    var body: some Scene {
        WindowGroup {
            FSTabView()
                .environment(
                    \.managedObjectContext,
                     PersistenceController.shared.container.viewContext
                )
        }
    }
}
