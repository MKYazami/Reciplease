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
