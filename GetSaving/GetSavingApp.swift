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
    @State var isHamburgerMenuShowing = false

    var body: some Scene {
        WindowGroup {
            MainTabbedView(presentSideMenu: isHamburgerMenuShowing, persistenceController: persistenceController)
        }
    }
}
