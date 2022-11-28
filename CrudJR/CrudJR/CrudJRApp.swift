//
//  CrudJRApp.swift
//  CrudJR
//
//  Created by CCDM09 on 23/11/22.
//

import SwiftUI

@main
struct CrudJRApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager() )
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
