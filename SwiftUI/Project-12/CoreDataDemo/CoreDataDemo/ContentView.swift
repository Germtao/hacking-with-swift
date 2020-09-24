//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by QDSG on 2020/9/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        entity: Wizard.entity(),
        sortDescriptors: []
    ) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("添加") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            Button("保存") {
                withAnimation {
                    do {
                        try moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("删除") {
                wizards.forEach {
                    moc.delete($0)
                }
                
                try? moc.save()
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
