//
//  DetailedRecipesSampleTests.swift
//  RecipleaseTests
//
//  Created by Mehdi on 07/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData
@testable import Reciplease

/// This structure contains some static methods to save detailed recipes for tests
struct DetailedRecipesSampleTests {
    
    private static let imageDataTest = "ImageDataTest".data(using: .utf8) as NSData?
    private static let sourceRecipeULR = "URL For Test"
    
    /// Give detailed recipe 1 for test purpose
    ///
    /// - Parameter context: the managed object context
    /// - RECIPE ID IS strowberry-milk1
    static func saveDetailedRecipeTest1(with context: NSManagedObjectContext) {
        let detailedRecipe = DetailedRecipeData(context: context)
        
        detailedRecipe.recipeName = "Strowberry Milk"
        detailedRecipe.ingredients = ["strowberry", "milk", "honey"]
        detailedRecipe.rating = 5
        detailedRecipe.recipeID = "strowberry-milk1"
        detailedRecipe.preparationTime = "45 m"
        detailedRecipe.imageData = imageDataTest
        detailedRecipe.sourceRecipeURL = sourceRecipeULR
        
        try? context.save()
        
    }
    
    /// Give detailed recipe 2 for test purpose
    ///
    /// - Parameter context: the managed object context
    /// - RECIPE ID IS fish-butter1
    static func saveDetailedRecipeTest2(with context: NSManagedObjectContext) {
        let detailedRecipe = DetailedRecipeData(context: context)
        
        detailedRecipe.recipeName = "Fish Butter"
        detailedRecipe.ingredients = ["fish", "butter", "lemon"]
        detailedRecipe.rating = 3
        detailedRecipe.recipeID = "fish-butter1"
        detailedRecipe.preparationTime = "25 m"
        detailedRecipe.imageData = imageDataTest
        detailedRecipe.sourceRecipeURL = sourceRecipeULR
        
        try? context.save()
        
    }
    
    /// Give detailed recipe 3 for test purpose
    ///
    /// - Parameter context: the managed object context
    /// - RECIPE ID IS beef-potato1
    static func saveDetailedRecipeTest3(with context: NSManagedObjectContext) {
        let detailedRecipe = DetailedRecipeData(context: context)
        
        detailedRecipe.recipeName = "Beef Potato"
        detailedRecipe.ingredients = ["beef", "potato", "salt"]
        detailedRecipe.rating = 4
        detailedRecipe.recipeID = "beef-potatoe1"
        detailedRecipe.preparationTime = "20 m"
        detailedRecipe.imageData = imageDataTest
        detailedRecipe.sourceRecipeURL = sourceRecipeULR
        
        try? context.save()
        
    }
    
}
