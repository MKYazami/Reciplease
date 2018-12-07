//
//  RecipeManagerTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 06/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class RecipeManagerTestCase: XCTestCase {
    
    // MARK: PROPERTIES
    var coreDataStack: CoreDataStack!
    var recipeManager: RecipeManager!
    
    // MARK: METHODS
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackTest()
        recipeManager = RecipeManager(coreDataStack: coreDataStack,
                                      managedContext: coreDataStack.mainContext)
    }
    
    override func tearDown() {
        
        deleteAllRecipeDataTests()
        // Reset core data stack & recipe manager after each test
        coreDataStack = nil
        recipeManager = nil
        super.tearDown()
    }
    
    private func deleteAllRecipeDataTests() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? coreDataStack.mainContext.execute(deleteRequest)
    }
    
    // MARK: TEST GET RECIPES
    func testGiven3RecipesSaved_WhenCallGetRecipes_ThenShouldGet3Recipes() {
        // Given
        RecipesSampleTests.saveRecipeTest1(with: coreDataStack.mainContext)
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.mainContext)
        RecipesSampleTests.saveRecipeTest3(with: coreDataStack.mainContext)
        
        // When
        let recipes = recipeManager.getRecipes
        
        // Then
        XCTAssertEqual(recipes.count, 3)
        
    }
    
    func testGivenRecipeSaved_WhenGetFirstRecipeID_ThenRecipeIDShouldEqualToExpectedRecipeID() {
        // Given
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.mainContext)
        let expectedRecipeID = "banana-cake1"
        
        // When
        let recipeID = recipeManager.getRecipes.first!.recipeID
        
        // Then
        XCTAssertEqual(recipeID, expectedRecipeID)
    }
    
    func testGivenNoRecipeSaved_WhenCallGetRecipes_ThenRecipesShouldBeEmpty() {
        // Given
        // NO RECIPE SAVED
        
        // When
        let recipes = recipeManager.getRecipes
        
        // Then
        XCTAssertTrue(recipes.isEmpty)
    }
    
    // MARK: TEST SAVE RECIPE FROM YUMMLY DATA
    func testGivenYummlyRecipe_WhenSaveRecipeAndCallGetRecipes_ThenRecipeIDShouldEqualToSavedRecipeID() {
        
        // Given
        let recipeID = "orange1"
        let ulrImageString = ImageURLSize(imageSize90: "image url string")
        let match = Match(rating: 3,
                           imageUrlsBySize: ulrImageString, recipeName: "Orange",
                           ingredients: ["orange", "milk"],
                           totalTimeInSeconds: 2000, recipeID: recipeID)
        let imageData = "imageData".data(using: .utf8)
        
        // When
        recipeManager.saveRecipeFromYummlyData(recipe: match, imageData: imageData)
        let recipes = recipeManager.getRecipes
        
        // Then
        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first!.recipeID,
                       recipeID,
                       "recipe ID should be same as in match")
    }
    
    func testGivenYummlyRecipeWithNoRating_WhenSaveRecipeAndCallGetRecipes_ThenRatingShouldEqualTo0() {
        // Given
        let ulrImageString = ImageURLSize(imageSize90: "image url string")
        let match = Match(rating: nil,
                          imageUrlsBySize: ulrImageString, recipeName: "Lemon",
                          ingredients: ["lemon", "apple"],
                          totalTimeInSeconds: 600, recipeID: "lemon1")
        let imageData = "imageData".data(using: .utf8)
        
        // When
        recipeManager.saveRecipeFromYummlyData(recipe: match, imageData: imageData)
        let rating = recipeManager.getRecipes.first!.rating
        
        // Then
        XCTAssertEqual(rating, 0, "If rating data nil, rating should equal to 0")
    }
    
    // MARK: TEST SAVE RECIPE FROM LOCAL DATA
    func testGivenRecipeData_WhenSaveRecipeData_ThenRecipeIDShouldEqualToSavedRecipeID() {
        // Given
        let expectedRecipeID = "rusty-chiken1"
        RecipesSampleTests.saveRecipeTest1(with: coreDataStack.mainContext)
        
        let recipeData = recipeManager.getRecipes.first!
        
        // When
        recipeManager.saveRecipeFromLocalData(recipeData: recipeData)
        
        // Then
        let recipes = recipeManager.getRecipes
        let recipeID = recipes.last!.recipeID
        XCTAssertEqual(recipeID,
                       expectedRecipeID,
                       "recipe ID should be same as recipe ID in recipeData")
        
    }
    
    // MARK: TEST REMOVE RECIPES
    func testGivenRecipes_WhenDeleteRecipe_ThenRecipeShouldNotExists() {
        // Given
        let expectedRecipeID = "butter-cookie1"
        // This is recipe to remove
        RecipesSampleTests.saveRecipeTest3(with: coreDataStack.mainContext)
        
        RecipesSampleTests.saveRecipeTest1(with: coreDataStack.mainContext)
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.mainContext)
        
        // When
        recipeManager.removeRecipeData(recipeID: expectedRecipeID)
        let recipes = recipeManager.getRecipes
        
        // Then
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeData.recipeID), expectedRecipeID)
        
        let results = try? coreDataStack.mainContext.fetch(fetchRequest)
        let recipeID = results?.first?.recipeID
        
        XCTAssertNil(recipeID)
        XCTAssertEqual(recipes.count, 2)
        
    }
    
    // MARK: TEST CHECK IF FAVORITE RECIPES IS EMPTY
    func testGiven1Recipe_WhenCheckIfFavoriteRecipeIsEmpty_ThenShouldReturnsFalse() {
        // Given
        RecipesSampleTests.saveRecipeTest2(with: coreDataStack.mainContext)
        
        // When
        let isFavoriteEmpty = recipeManager.isFavoriteRecipeEmpty
        
        // Then
        XCTAssertFalse(isFavoriteEmpty)
    }
    
    func testGivenNoRecipe_WhenCheckIfFavoriteRecipeIsEmpty_ThenShouldReturnsTrue() {
        // Given
        // NO RECIPE
        
        // When
        let isFavoriteEmpty = recipeManager.isFavoriteRecipeEmpty
        
        // Then
        XCTAssertTrue(isFavoriteEmpty)
    }
}
