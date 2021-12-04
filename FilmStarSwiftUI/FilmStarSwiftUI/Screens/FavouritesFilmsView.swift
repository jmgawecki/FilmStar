//
//  FavouritesFilmsView.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import SwiftUI

struct FavouritesFilmsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @ObservedObject var viewModel: FSViewModel
    var body: some View {
            List {
                ForEach(items) { item in

                        FilmSumCell()
                
                        .onTapGesture {
                            viewModel.film = Film.mock
                        }


                }
                .onDelete(perform: deleteItems)
            }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FavouritesFilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesFilmsView(viewModel: FSViewModel())
    }
}
