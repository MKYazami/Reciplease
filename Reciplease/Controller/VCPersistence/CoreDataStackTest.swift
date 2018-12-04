//
//  CoreDataStackTest.swift
//  RecipleaseTests
//
//  Created by Mehdi on 04/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData
@testable import Reciplease

/// This class is used to override CoreDataStack and use "in memory store type" instead of "managed object result type".
/// - The goal is to test the operations related to the persistence without interfering with the application data
class CoreDataStackTest: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        
        setPersistentContainerForTest(modelName: modelName)
    }
    
    /// Allows to set persistent store container for test
    ///
    /// - Parameter modelName: name of the model to load
    private func setPersistentContainerForTest(modelName: String) {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Error to load persistent container for tests: \(error) \n Description: \(error.userInfo)")
            }
        }
        
        self.container = container
    }
    
}
