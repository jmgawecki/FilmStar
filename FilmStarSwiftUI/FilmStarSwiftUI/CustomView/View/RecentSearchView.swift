import SwiftUI
import CoreData

struct RecentSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(items) { item in
                        RecentFilmCell()
                    }
                    .onDelete(perform: deleteItems)
                }
            }
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct RecentFilmCell: View {
    let film = FilmMock.gogv2
    var body: some View {
        ZStack {
            HStack {
                Image("LogoSearchScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .cornerRadius(10)
                    .padding(.top)
                VStack(alignment: .leading) {
                    Text(film.title)
                        .font(.subheadline)
                    Text(film.genre)
                        .font(.callout)
                    Text("By \(film.director)")
                        .font(.caption)
                }
                .multilineTextAlignment(.leading)
            }
            .frame(height: 100)
        }
    }
}
