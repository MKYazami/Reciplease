//
//  DetailedRecipeManager.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData

/// Manage detailed recipe data (add, get, delete, update) 
struct DetailedRecipeManager:  CoreDataManager {
    
    // MARK: PROPERTIES
    var coreDataStack: CoreDataStack
    var managedContext: NSManagedObjectContext
    
}
