//
//  Movie_AppApp.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

@main
struct Movie_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Temp()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
