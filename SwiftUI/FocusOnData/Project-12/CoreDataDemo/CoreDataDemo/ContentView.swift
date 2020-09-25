//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by QDSG on 2020/9/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let persistence = PersistenceController.shared

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<6) { index in
                    switch index {
                    case 0:
                        NavigationLink(
                            "使用约束确保CoreData对象是唯一的",
                            destination: WizardContentView().environment(\.managedObjectContext, persistence.container.viewContext)
                        )
                    case 1:
                        NavigationLink(
                            "使用NSPredicate过滤@FetchRequest",
                            destination: ShipContentView().environment(\.managedObjectContext, persistence.container.viewContext)
                        )
                    case 2:
                        NavigationLink(
                            "使用SwiftUI动态过滤@FetchRequest",
                            destination: DynamicFilteringContentView().environment(\.managedObjectContext, persistence.container.viewContext)
                        )
                    case 3:
                        NavigationLink(
                            "与CoreData，SwiftUI和@FetchRequest的一对多关系",
                            destination: OneToManyRelationshipsContentView().environment(\.managedObjectContext, persistence.container.viewContext)
                        )
                    default: Text("default")
                    }
                }
            }
            .navigationBarTitle("Core Data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
