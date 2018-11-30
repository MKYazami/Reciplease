//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData

/// This class allows to prepare the core data stack and to be able to use it for the production as well as for the tests
class CoreDataStack {
    
    // MARK: PROPERTIES
    private let modelName: String

    /// This internal property must be changed (overrided) only for tests purpose to change persistent store type
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("""
                    Error to load persistent strore: \(error)
                    Description: \(error.userInfo)
                    """)
            }
        }
        
        return container
    }()
    
    /// This context is used on main thread
    lazy var mainContext: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    // MARK: INIT
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: METHODS
    
    /// Saves the context in case it has changed
    func saveContext() {
        guard mainContext.hasChanges else { return }
        
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("""
                Error to save the context after it is modified: \(error)
                Description: \(error.userInfo)
                """)
        }
        
    }
    
}
