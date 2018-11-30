//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData

/// This protocol must be implemented in strcutures/classes that need to manage data in Core Data
protocol CoreDataManager {
    var coreDataStack: CoreDataStack { get set }
    var managedContext: NSManagedObjectContext { get set }
}
