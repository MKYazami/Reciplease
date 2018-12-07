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

class CoreDataStackTest: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
}
