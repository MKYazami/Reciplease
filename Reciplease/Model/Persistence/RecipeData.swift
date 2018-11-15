//
//  RecipeData.swift
//  Reciplease
//
//  Created by Mehdi on 05/10/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData

class RecipeData: NSManagedObject {
    
    /// Returns the list of all Recipes to present in list
    /// - In case of no data, the array will be empty
    static var getRecipes: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
                
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        
        return recipes
    }
    
    /// Allows to save recipe from remote API Yummli which contains a data structure Match
    ///
    /// - Parameters:
    ///   - recipe: recipe result is stored in Match data structure
    ///   - imageData: image under form of data
    static func saveRecipeFromYummlyData(recipe: Match, imageData: Data?) {
        let recipeName = recipe.recipeName
        let recipeID = recipe.recipeID
        let rating = recipe.rating ?? 0
        let ingredients = recipe.ingredients
        let totalTimeInSeconds = recipe.totalTimeInSeconds
        
        // Save data
        let listRecipeData = RecipeData(context: AppDelegate.viewContext)
        listRecipeData.recipeName = recipeName
        listRecipeData.recipeID = recipeID
        listRecipeData.rating = Int16(rating)
        listRecipeData.image = imageData
        listRecipeData.ingredients = ingredients as NSArray
        listRecipeData.totalTimeInSeconds = Int16(totalTimeInSeconds)
        
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print("Recipe in list saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    /// Remove recipe from persistence with the help of recipe ID
    ///
    /// - Parameter recipeID: the ID of recipe
    static func removeRecipeData(recipeID: String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeData")
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeData.recipeID), recipeID)
        
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try AppDelegate.viewContext.execute(request)
        } catch let error as NSError {
            print("Error to delete detailed recipe \(error) \n Description: \(error.userInfo)")
        }
    }
    
}

class DetailedRecipeData: NSManagedObject {
    
    /// Allows to get the fetch request of DetailedRecipeData
    ///
    /// - Parameter recipeID: recipe ID of the recipe you want to get the detail
    /// - Returns: fetch request concerning the DetailedRecipeData
    static func getDetailedRecipesFetchRequest(recipeID: String) -> NSFetchRequest<DetailedRecipeData> {
        
        let fetchRequest: NSFetchRequest<DetailedRecipeData> = DetailedRecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DetailedRecipeData.recipeID), recipeID)
        
        return fetchRequest
    }
    
    /// Save the detailed recipe
    ///
    /// - Parameters:
    ///   - detailedRecipe: detailed recipe structure
    ///   - recipeID: recipe ID
    ///   - imageData: image under form of data
    ///   - preparationTime: time of preparation as String
    static func saveDetailedRecipeFromYummlyData(detailedRecipe: DetailedRecipe, recipeID: String?, imageData: Data?, preparationTime: String?) {
        // Get detail recipe items
        let recipeName = detailedRecipe.name
        let rating = detailedRecipe.rating
        let ingredients = detailedRecipe.ingredientLines
        let sourceRecipeURL = detailedRecipe.source.sourceRecipeUrl
        
        // Save data
        let detailedRecipeData = DetailedRecipeData(context: AppDelegate.viewContext)
        detailedRecipeData.recipeName = recipeName
        detailedRecipeData.recipeID = recipeID
        detailedRecipeData.rating = Int16(rating)
        detailedRecipeData.preparationTime = preparationTime
        detailedRecipeData.image = imageData
        detailedRecipeData.ingredients = ingredients as NSArray
        detailedRecipeData.sourceRecipeURL = sourceRecipeURL
        
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
}
