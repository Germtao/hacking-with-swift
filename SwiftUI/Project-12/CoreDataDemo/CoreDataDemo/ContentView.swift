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
        entity: Ship.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "universe == 'Star Wars'")
        // or NSPredicate(format: "universe == %@", "Star Wars")
        // or NSPredicate(format: "name < %@", "F")
        // NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
        // NSPredicate(format: "name BEGINSWITH %@", "E")
        // NSPredicate(format: "name BEGINSWITH[c] %@", "e") 忽略大小写
        // NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")
    ) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("添加例子") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
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
