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
    
    static var getAllRecipes: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        
        return recipes
    }
    
}

class DetailedRecipeData: NSManagedObject {
    
}
