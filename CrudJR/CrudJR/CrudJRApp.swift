//
//  CrudJRApp.swift
//  CrudJR
//
//  Created by CCDM09 on 23/11/22.
//

import SwiftUI

@main
struct CrudJRApp: App {
    let coreDM = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: coreDM)
        }
    }
}
