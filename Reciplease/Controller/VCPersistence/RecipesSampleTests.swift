//
//  RecipesSampleTests.swift
//  RecipleaseTests
//
//  Created by Mehdi on 06/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData
@testable import Reciplease

/// This structure contains some static methods to save recipes for tests
struct RecipesSampleTests {
    
    private static let imageDataTest = "ImageDataTest".data(using: .utf8) as NSData?
    
    /// Give recipe 1 for test purpose
    ///
    /// - Parameter context: the managed object context
    /// - Returns: recipe
    /// - RECIPE ID IS rusty-chiken1
    static func saveRecipeTest1(with context: NSManagedObjectContext) {
        let recipe = RecipeData(context: context)
        
        recipe.recipeName = "Rusty Chiken"
        recipe.ingredients = ["garlic", "maple syrup", "soy sauce"]
        recipe.rating = 4
        recipe.recipeID = "rusty-chiken1"
        recipe.totalTimeInSeconds = 5400
        recipe.imageData = imageDataTest
        
    }
    
    /// Give recipe 2 for test purpose
    ///
    /// - Parameter context: the managed object context
    /// - Returns: recipe
    /// - RECIPE ID IS banana-cake1
    static func saveRecipeTest2(with context: NSManagedObjectContext) {
        let recipe = RecipeData(context: context)
        
        recipe.recipeName = "Banana Cake"
        recipe.ingredients = ["cup butter", "white sugar", "egg"]
        recipe.rating = 3
        recipe.recipeID = "banana-cake1"
        recipe.totalTimeInSeconds = 2400
        recipe.imageData = imageDataTest
        
    }
    
    /// Give recipe 3 for test purpose
    ///
    /// - Parameter context: the managed object context
    /// - Returns: recipe
    /// - RECIPE ID IS butter-cookie1
    static func saveRecipeTest3(with context: NSManagedObjectContext) {
        let recipe = RecipeData(context: context)
        
        recipe.recipeName = "Butter Cookie"
        recipe.ingredients = ["butter", "almont", "milk"]
        recipe.rating = 5
        recipe.recipeID = "butter-cookie1"
        recipe.totalTimeInSeconds = 2700
        recipe.imageData = imageDataTest
        
    }
    
}
