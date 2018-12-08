//
//  CoreDataStackTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 08/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataStackTestCase: XCTestCase {
    
    // MARK: PROPERTY
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackTest()
    }

    override func tearDown() {
        coreDataStack = nil
        super.tearDown()
    }
    
    func testGivenContext_WhenContextHasNotChanged_ThenContextShouldNotSave() {
        // Given
        let context = coreDataStack.mainContext
        
        // When
        // CONTEXT NOT CHANGED
        
        // Then
        XCTAssertTrue(context.hasChanges == false,
                      "Should returns false because no change in context is made")
        coreDataStack.saveContext()
    }
    
    func testGivenContext_WhenContextChanged_ThenContextShouldSave() {
        // Given
        let context = coreDataStack.mainContext
        
        // When
        RecipesSampleTests.saveRecipeTest1(with: context)
        let fetch: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeData.recipeID), "rusty-chiken1")

        // Then
        XCTAssertTrue(context.hasChanges == true,
                      "Should returns true because context changed and will be saved")

        coreDataStack.saveContext()
    }

}
