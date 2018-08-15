//
//  RecipeService.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class RecipeService {
    private let urlStringType: URLStringType
    private let recipeSession: URLSession
    
    init(urlStringType: URLStringType, recipeSession: URLSession) {
        self.urlStringType = urlStringType
        self.recipeSession = recipeSession
    }
    
    func downloadRecipe(ingredients: [String], callback: @escaping (Bool, Recipe?) -> Void) {
        
    }
    
    /// Allows to extract an ingredients array to formated ingredients string to send them in url parameter
    ///
    /// - Parameter ingredients: Array of ingredients coming from user
    /// - Returns: URL string for API query
    private func extractIngredientsArrayToURLString(ingredients: [String]) -> String {
        return ""
    }
}
