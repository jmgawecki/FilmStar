//
//  FilmStarSwiftUIApp.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 02/12/2021.
//

import SwiftUI

@main
struct FilmStarSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
