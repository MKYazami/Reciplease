//
//  DetailedRecipeManager.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import CoreData

/// Manage detailed recipe data (add, get, delete, update) 
struct DetailedRecipeManager: CoreDataManager {
    
    // MARK: PROPERTIES
    var alertMessageDelegate: ListenToAlertMessage?
    
    var coreDataStack: CoreDataStack
    var managedContext: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStack, managedContext: NSManagedObjectContext) {
        self.coreDataStack = coreDataStack
        self.managedContext = managedContext
    }
    
}

// MARK: GET DETAILED RECIPES
extension DetailedRecipeManager {
    
    /// Allows to get the fetch request of DetailedRecipeData
    ///
    /// - Parameter recipeID: recipe ID of the recipe you want to get the detail
    /// - Returns: fetch request concerning the DetailedRecipeData
    func getDetailedRecipesFetchRequest(recipeID: String) -> NSFetchRequest<DetailedRecipeData> {
        
        let fetchRequest: NSFetchRequest<DetailedRecipeData> = DetailedRecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(DetailedRecipeData.recipeID), recipeID)
        
        return fetchRequest
    }
    
}

// MARK: SAVE DETAILED RECIPE
extension DetailedRecipeManager {
    
    /// Save the detailed recipe
    ///
    /// - Parameters:
    ///   - detailedRecipe: detailed recipe structure
    ///   - recipeID: recipe ID
    ///   - imageData: image under form of data
    ///   - preparationTime: time of preparation as String
    func saveDetailedRecipeFromYummlyData(detailedRecipe: DetailedRecipe, recipeID: String?, imageData: Data?, preparationTime: String?) {
        // Prepare data
        let recipeName = detailedRecipe.name
        let rating = detailedRecipe.rating
        let ingredients = detailedRecipe.ingredientLines
        let sourceRecipeURL = detailedRecipe.source.sourceRecipeUrl
        
        // Save data
        let detailedRecipeData = DetailedRecipeData(context: managedContext)
        detailedRecipeData.recipeName = recipeName
        detailedRecipeData.recipeID = recipeID
        detailedRecipeData.rating = Int16(rating)
        detailedRecipeData.preparationTime = preparationTime
        detailedRecipeData.imageData = imageData  as NSData?
        detailedRecipeData.ingredients = ingredients as NSArray
        detailedRecipeData.sourceRecipeURL = sourceRecipeURL
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
            alertMessageDelegate?.alertMessage(alertTitle: Constants.AlertMessage.saveRecipeErrorTitle,
                                               message: Constants.AlertMessage.saveRecipeErrorDescription,
                                               actionTitle: Constants.AlertMessage.actionTitleOK)
        }
    }
    
    /// Allows to save detailed recipe again (after deleted) from local data that are already previously saved
    ///
    /// - Parameter detailedRecipe: DetailedRecipe structure
    func saveDetailedRecipeFromLocalData(detailedRecipe: DetailedRecipeData) {
        // Prepare data
        let recipeName = detailedRecipe.recipeName
        let recipeID = detailedRecipe.recipeID
        let rating = detailedRecipe.rating
        let preparationTime = detailedRecipe.preparationTime
        let recipeImageData = detailedRecipe.imageData
        let ingredients = detailedRecipe.ingredients
        let sourceRecipeURL = detailedRecipe.sourceRecipeURL
        
        // Save data
        let detailedRecipeData = DetailedRecipeData(context: managedContext)
        detailedRecipeData.recipeName = recipeName
        detailedRecipeData.recipeID = recipeID
        detailedRecipeData.rating = rating
        detailedRecipeData.preparationTime = preparationTime
        detailedRecipeData.imageData = recipeImageData
        detailedRecipeData.ingredients = ingredients
        detailedRecipeData.sourceRecipeURL = sourceRecipeURL
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error to save detailed recipe: \(error) \n Description: \(error.userInfo)")
            alertMessageDelegate?.alertMessage(alertTitle: Constants.AlertMessage.saveRecipeErrorTitle,
                                               message: Constants.AlertMessage.saveRecipeErrorDescription,
                                               actionTitle: Constants.AlertMessage.actionTitleOK)
        }
    }
    
}

// MARK: REMOVE DETAILED RECIPE
extension DetailedRecipeManager {
    
    /// Removes detailed recipe with the help of recipe ID
    ///
    /// - Parameter recipeID: ID of recipe
    func removeDetailedRecipeData(recipeID: String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DetailedRecipeData")
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(DetailedRecipeData.recipeID), recipeID)
        
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

// MARK: CHECK IF DETAILED RECIPE EXISTS
extension DetailedRecipeManager {
    
    func isRecipeExists(recipeID: String) -> Bool {
        
        let recipeIDFetch: NSFetchRequest<DetailedRecipeData> = DetailedRecipeData.fetchRequest()
        recipeIDFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(DetailedRecipeData.recipeID), recipeID)
        
        do {
            let countResult = try managedContext.count(for: recipeIDFetch)
            
            guard countResult > 0 else { return false }
            return true
        } catch let error as NSError {
            print("Error to check if recipe exists in DB: \n \(error)")
            return false
        }
        
    }
    
}
