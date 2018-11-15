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
    
}
