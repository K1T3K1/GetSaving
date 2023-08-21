//
//  GetSavingApp.swift
//  GetSaving
//
//  Created by Kajetan Patryk Zarzycki on 21/08/2023.
//

import SwiftUI

@main
struct GetSavingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
