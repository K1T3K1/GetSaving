//
//  MainTabbedView.swift
//  GetSaving
//
//  Created by Kajetan Patryk Zarzycki on 26/08/2023.
//

import SwiftUI

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    var persistenceController: PersistenceController
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedSideMenuTab) {
                TransactionView(isSideMenuShowing: $presentSideMenu)
                    .environment(\.managedObjectContext,
                        persistenceController.container.viewContext)
                    .tag(1)
            }
            
            HamburgerSideMenuView(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct MainTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbedView(persistenceController: PersistenceController())
    }
}
