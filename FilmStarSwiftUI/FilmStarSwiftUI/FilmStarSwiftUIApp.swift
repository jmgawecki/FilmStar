import SwiftUI

@main
struct FilmStarSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabViewScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
