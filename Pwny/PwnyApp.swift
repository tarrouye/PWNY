//
//  PwnyApp.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/20/21.
//

import SwiftUI

@main
struct PwnyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
