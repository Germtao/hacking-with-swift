//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by QDSG on 2020/9/23.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
