//
//  AddBookView.swift
//  Bookworm
//
//  Created by QDSG on 2020/9/22.
//

import SwiftUI

struct AddBookView: View {
    /// 托管对象上下文
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("书名", text: $title)
                    TextField("作者", text: $author)
                    
                    Picker("书籍类型", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Picker("评分", selection: $rating) {
                        ForEach(0..<6) {
                            Text("\($0)")
                        }
                    }
                    
                    TextField("评论", text: $review)
                }
                
                Section {
                    Button("保存") {
                        addBook()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    private func addBook() {
        let newBook = Book(context: moc)
        newBook.title = title
        newBook.author = author
        newBook.genre = genre
        newBook.rating = Int16(rating)
        newBook.review = review
        
        try? moc.save()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
