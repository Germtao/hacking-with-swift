//
//  ContentView.swift
//  Bookworm
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    /// 使用@FetchRequest建立 list
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
            NSSortDescriptor(keyPath: \Book.author, ascending: true)
        ]
    ) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(
                        destination: DetailView(book: book),
                        label: {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "未知")
                                    .font(.headline)
                                Text(book.author ?? "未知")
                                    .foregroundColor(.secondary)
                            }
                        }
                    )
                }
            }
            .navigationBarTitle("书架")
            .navigationBarItems(trailing: Button(action: { showingAddScreen.toggle() }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showingAddScreen, content: {
                AddBookView().environment(\.managedObjectContext, moc)
            })
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
        ContentView()
    }
}
