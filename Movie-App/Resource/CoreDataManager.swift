//
//  CoreDataManager.swift
//  Movie-App
//
//  Created by William Santoso on 17/09/23.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Movie_App")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
        
        viewContext = container.viewContext
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
