//
//  RecipeManager.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData

/// Manage recipe data (add, get, delete, update)
struct RecipeManager: CoreDataManager {
    
    // MARK: PROPERTIES
    var alertMessageDelegate: ListenToAlertMessage?
    
    var coreDataStack: CoreDataStack
    var managedContext: NSManagedObjectContext

}

// MARK: GET RECIPES
extension RecipeManager {
    /// Returns the list of all Recipes to present in list
    /// - In case of no data, the array will be empty
    var getRecipes: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        
        guard let recipes = try? managedContext.fetch(request) else { return [] }
        
        return recipes
    }
}

// MARK: SAVE RECIPES
extension RecipeManager {
    
    /// Allows to save recipe from remote API Yummli which contains a data structure Match
    ///
    /// - Parameters:
    ///   - recipe: recipe result is stored in Match data structure
    ///   - imageData: image under form of data
    func saveRecipeFromYummlyData(recipe: Match, imageData: Data?) {
        // Prepare data
        let recipeName = recipe.recipeName
        let recipeID = recipe.recipeID
        let rating = recipe.rating ?? 0
        let ingredients = recipe.ingredients
        let totalTimeInSeconds = recipe.totalTimeInSeconds
        
        // Save data
        let listRecipeData = RecipeData(context: managedContext)
        listRecipeData.recipeName = recipeName
        listRecipeData.recipeID = recipeID
        listRecipeData.rating = Int16(rating)
        listRecipeData.imageData = imageData as NSData?
        listRecipeData.ingredients = ingredients as NSArray
        listRecipeData.totalTimeInSeconds = Int16(totalTimeInSeconds)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Recipe in list saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
            alertMessageDelegate?.alertMessage(alertTitle: Constants.AlertMessage.saveRecipeErrorTitle,
                                               message: Constants.AlertMessage.saveRecipeErrorDescription,
                                               actionTitle: Constants.AlertMessage.actionTitleOK)
        }
    }
    
    /// Allows to save recipe again (after deleted) from local data that are already previously saved
    ///
    /// - Parameter recipeData: RecipeData structure
    func saveRecipeFromLocalData(recipeData: RecipeData) {
        // Prepare data
        let recipeName = recipeData.recipeName
        let recipeID = recipeData.recipeID
        let rating = recipeData.rating
        let imageData = recipeData.imageData
        let ingredients = recipeData.ingredients
        let totalTimeInSeconds = recipeData.totalTimeInSeconds
        
        // Save data
        let recipeData = RecipeData(context: managedContext)
        recipeData.recipeName = recipeName
        recipeData.recipeID = recipeID
        recipeData.rating = rating
        recipeData.imageData = imageData
        recipeData.ingredients = ingredients
        recipeData.totalTimeInSeconds = totalTimeInSeconds
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error to save recipe in list: \(error) \n Description: \(error.userInfo)")
            alertMessageDelegate?.alertMessage(alertTitle: Constants.AlertMessage.saveRecipeErrorTitle,
                                               message: Constants.AlertMessage.saveRecipeErrorDescription,
                                               actionTitle: Constants.AlertMessage.actionTitleOK)
        }
    }
    
}

// MARK: REMOVE RECIPES
extension RecipeManager {
    
    /// Remove recipe from persistence with the help of recipe ID
    ///
    /// - Parameter recipeID: the ID of recipe
    func removeRecipeData(recipeID: String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeData")
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeData.recipeID), recipeID)
        
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try managedContext.execute(request)
        } catch let error as NSError {
            print("Error to delete detailed recipe \(error) \n Description: \(error.userInfo)")
            alertMessageDelegate?.alertMessage(alertTitle: Constants.AlertMessage.deleteRecipeErrorTitle,
                                               message: Constants.AlertMessage.deleteRecipeErrorDescription,
                                               actionTitle: Constants.AlertMessage.actionTitleOK)
        }
    }
    
}

// MARK: CHECK IF RECIPE EXISTS
extension RecipeManager {
    
    var isFavoriteRecipeEmpty: Bool {
        let fetchRecipes: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        
        do {
            let countResult = try managedContext.count(for: fetchRecipes)
            guard countResult > 0 else { return true }
            
            return false
        } catch let error as NSError {
            print("Fetch count result error: \(error) \n Description: \(error.userInfo) ")
            return true
        }
    }
    
}
