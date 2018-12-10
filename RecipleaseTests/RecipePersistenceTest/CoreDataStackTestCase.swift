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
    
    // MARK: METHODS
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackTest()
    }

    override func tearDown() {
        coreDataStack = nil
        super.tearDown()
    }
    
    private func unsavedContextRecipe(with context: NSManagedObjectContext) {
        let recipe = RecipeData(context: context)
        
        recipe.recipeName = "Butter Cookie"
        recipe.ingredients = ["butter", "almont", "milk"]
        recipe.rating = 5
        recipe.recipeID = "butter-cookie1"
        recipe.totalTimeInSeconds = 2700
        recipe.imageData = "ImageTestData".data(using: .utf8) as NSData?
        
        // WE DONT SAVE CONTEXT
        
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
        unsavedContextRecipe(with: context)
        let fetch: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeData.recipeID), "butter-cookie1")

        // Then
        XCTAssertTrue(context.hasChanges == true,
                      "Should returns true because context changed and should be saved")

        coreDataStack.saveContext()
        
        XCTAssertTrue(context.hasChanges == false,
                      "Sould returns false because context is saved and not changed after")
    }

}
