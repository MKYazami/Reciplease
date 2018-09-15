//
//  YummlyURLString.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct YummlyURLString: URLStringType {
    
    private var ingredients: [String]
    
    var urlString: String {
        return Constants.YummlyAPI.urlString + extractIngredientsArrayToIngredientsString()
    }
    
    /// Inject the ingredients as String Array to get recipes results
    ///
    /// - Parameter ingredients: Ingredient in String Array
    init(ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    /// Allows to extract an ingredients array to formated ingredients string to send them in url parameter
    ///
    /// - Returns: Query ingredients string for API query
    private func extractIngredientsArrayToIngredientsString() -> String {
        var ingredientsStr = ""
        
        for ingredient in ingredients {
            // Removing ”﹆ ” to perform a clean request to the API
            let cleanStringIngredient = ingredient.replacingOccurrences(of: "﹆ ", with: "")
            
            if ingredient == ingredients.last {
                ingredientsStr += "\(cleanStringIngredient)"
            } else {
                // Add + after each ingredient if ≠ to last item
                ingredientsStr += "\(cleanStringIngredient)+"
            }
        }
        
        return ingredientsStr
    }
}
