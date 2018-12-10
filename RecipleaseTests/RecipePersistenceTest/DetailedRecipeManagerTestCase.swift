//
//  DetailedRecipeManagerTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 07/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class DetailedRecipeManagerTestCase: XCTestCase {
    
    // MARK: PROPERTIES
    var coreDataStack: CoreDataStack!
    var detailedRecipeManager: DetailedRecipeManager!
    
    // MARK: METHODS
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackTest()
        detailedRecipeManager = DetailedRecipeManager(coreDataStack: coreDataStack,
                                                      managedContext: coreDataStack.mainContext)
    }
    
    override func tearDown() {
        deleteAllDetailedRecipeDataTests()
        coreDataStack = nil
        detailedRecipeManager = nil
        super.tearDown()
    }
    
    private func deleteAllDetailedRecipeDataTests() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DetailedRecipeData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? coreDataStack.mainContext.execute(deleteRequest)
    }
    
    // MARK: GET DETAILED RECIPES
    func testGiven3DetailedRecipesSaved_WhenCallGetDetailedRecipesFetchRequest_ThenShouldGetDetailedRecipeThatFetched() {
        // Given
        let expectedRecipeID = "strowberry-milk1"
        DetailedRecipesSampleTests.saveDetailedRecipeTest1(with: coreDataStack.mainContext)
        DetailedRecipesSampleTests.saveDetailedRecipeTest2(with: coreDataStack.mainContext)
        DetailedRecipesSampleTests.saveDetailedRecipeTest3(with: coreDataStack.mainContext)
        
        // When
        let fetcheRequest = detailedRecipeManager.getDetailedRecipesFetchRequest(recipeID: expectedRecipeID)
        
        // Then
        let recipes = try? coreDataStack.mainContext.fetch(fetcheRequest)
        let recipeID = recipes?.first!.recipeID
        
        XCTAssertTrue(recipeID == expectedRecipeID)
        
    }
    
    func testGivenNoDetailedRecipeSaved_WhenCallGetDetailedRecipesFetchRequest_ThenShouldGetEmptyFetchRequest() {
        // Given
        // NO DETAILED RECIPE
        
        // When
        let fetcheRequest = detailedRecipeManager.getDetailedRecipesFetchRequest(recipeID: "")
        
        // Then
        guard let recipes = try? coreDataStack.mainContext.fetch(fetcheRequest) else { return }
        
        XCTAssertTrue(recipes.isEmpty)
    }
    
    // MARK: SAVE DETAILED RECIPE
    func testGivenYummlyDetailedRecipe_WhenSaveRecipeAndCallGetDetailedRecipes_ThenRecipeIDShouldEqualToSavedRecipeID() {
        // Given
        let expectedRecipeID = "kiwi-lemon1"
        let sourceURL = Source(sourceRecipeUrl: "Fake URL Test")
        let urlImages = URLImages(hostedLargeUrl: "Fake URL Img")
        let detailedRecipe = DetailedRecipe(name: "Kiwi Lemon",
                                                ingredientLines: ["kiwi", "lemon", "sugar"],
                                                source: sourceURL,
                                                images: [urlImages],
                                                rating: 3,
                                                totalTimeInSeconds: 1200)
        // When
        detailedRecipeManager.saveDetailedRecipeFromYummlyData(detailedRecipe: detailedRecipe,
                                                               recipeID: expectedRecipeID,
                                                               imageData: "imageData".data(using: .utf8),
                                                               preparationTime: "5 m")
        
        let detailedRecipeFetchRequest = detailedRecipeManager.getDetailedRecipesFetchRequest(recipeID: expectedRecipeID)
        
        let recipes = try? coreDataStack.mainContext.fetch(detailedRecipeFetchRequest)
        guard let recipeID = recipes?.first?.recipeID else { return }
        
        // Then
        XCTAssertTrue(recipeID == expectedRecipeID)
    }
    
    // MARK: TEST SAVE RECIPE FROM LOCAL DATA
    func testGivenDetailedRecipeData_WhenSaveDetailedRecipeData_ThenRecipeIDShouldEqualToSavedRecipeID() {
        // Given
        let expectedRecipeID = "fish-butter1"
        DetailedRecipesSampleTests.saveDetailedRecipeTest2(with: coreDataStack.mainContext)
        
        let detailedRecipeDataFetchRequest = detailedRecipeManager.getDetailedRecipesFetchRequest(recipeID: expectedRecipeID)
        let detailedRecipes = try? coreDataStack.mainContext.fetch(detailedRecipeDataFetchRequest)
        guard let detailedRecipe = detailedRecipes?.first else { return }
        let recipeID = detailedRecipe.recipeID
        // When
        detailedRecipeManager.saveDetailedRecipeFromLocalData(detailedRecipe: detailedRecipe)
        
        // Then
        XCTAssertTrue(recipeID == expectedRecipeID)
        
    }
    
    // MARK: TEST REMOVE DETAILED RECIPE
    func testGivenDetailedRecipes_WhenDeleteDetailedRecipe_ThenDetailedRecipeShouldNotExists() {
        // Given
        let expectedRecipeID = "strowberry-milk1"
        // This is recipe to remove
        DetailedRecipesSampleTests.saveDetailedRecipeTest1(with: coreDataStack.mainContext)
        
        DetailedRecipesSampleTests.saveDetailedRecipeTest2(with: coreDataStack.mainContext)
        DetailedRecipesSampleTests.saveDetailedRecipeTest3(with: coreDataStack.mainContext)
        
        // When
        detailedRecipeManager.removeDetailedRecipeData(recipeID: expectedRecipeID)
        
        // Then
        let fetchRequest: NSFetchRequest<DetailedRecipeData> = DetailedRecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DetailedRecipeData.recipeID), expectedRecipeID)
        
        guard let results = try? coreDataStack.mainContext.fetch(fetchRequest) else { return }
        let recipeID = results.first?.recipeID
        
        XCTAssertTrue(results.isEmpty,
                      "The results should be empty, because we fetch detailed recipe that is removed")
        XCTAssertNil(recipeID,
                     "recipe ID is nil, because detailed recipe is removed")
        
    }
    
    // MARK: TEST CHECK IF DETAILED RECIPE EXISTS
    
    func testGiven1DetailedRecipeSaved_WhenCheckIfDetailedRecipeSavedExists_ThenShouldReturnsTrue() {
        // Given
        let expectedRecipeID = "strowberry-milk1"
        DetailedRecipesSampleTests.saveDetailedRecipeTest1(with: coreDataStack.mainContext)
        
        // When
        let isDetailedRecipeExists = detailedRecipeManager.isRecipeExists(recipeID: expectedRecipeID)
        
        // Then
        XCTAssertTrue(isDetailedRecipeExists)
    }
    
    func testGiven1DetailedRecipeSaved_WhenCheckIfDetailedRecipeNotSavedExists_ThenShouldReturnsFalse() {
        // Given
        let noSavedRecipeID = "strowberry-milk1"
        DetailedRecipesSampleTests.saveDetailedRecipeTest3(with: coreDataStack.mainContext)
        
        // When
        let isDetailedRecipeExists = detailedRecipeManager.isRecipeExists(recipeID: noSavedRecipeID)
        
        // Then
        XCTAssertFalse(isDetailedRecipeExists)
    }
}
