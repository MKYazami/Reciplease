//
//  RecipeService.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import Alamofire

class RecipeService {
    
    private let sessionType: SessionType
    
    /// Init the recipe service with SessionType, if we need a specific session we set it in the init in recipeSession
    ///
    /// - Parameters:
    ///   - urlStringType: URL String Type
    init(sessionType: SessionType) {
        self.sessionType = sessionType
    }
    
    /// Download recipes from remote API
    ///
    /// - Parameter callback: Contains 2 parameters 1 Bool for to set success and the second Recipe to get recipes
    func downloadRecipe(callback: @escaping (Bool, Recipe?) -> Void) {
        
        let urlString = sessionType.urlString
        guard let url = URL(string: urlString) else { return }
        
        sessionType.request(url: url) { (responseData) in
            // Check if data ≠ nil & no error
            guard let data = responseData.data, responseData.error == nil else {
                callback(false, nil)
                return
            }
            
            // Check correct response
            guard let response = responseData.response, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            // Decode JSON data
            guard let recipes = try? JSONDecoder().decode(Recipe.self, from: data) else {
                callback(false, nil)
                return
            }
            
            // The purpose of this check is to verify that Recipe's array matches is not empty due to a wrong response from the API when the user enters certain couple of ingredients
            guard recipes.matches.count > 0 else {
                callback(false, nil)
                return
            }
            
            // If all verifications success return callback true & recipe
            callback(true, recipes)
        }
        
    }
    
    /// Download detailed recipe from remote API
    ///
    /// - Parameter callback: Contains 2 parameters 1 Bool for set success and the second DetailedRecipe to get the detail of recipes
    func downloadDetailedRecipe(callback: @escaping (Bool, DetailedRecipe?) -> Void) {
        
        let urlString = sessionType.urlString
        guard let url = URL(string: urlString) else { return }
        
        sessionType.request(url: url) { (responseData) in
            // Check if data ≠ nil & no error
            guard let data = responseData.data, responseData.error == nil else {
                callback(false, nil)
                return
            }
            
            // Check correct response
            guard let response = responseData.response, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            // Decode JSON data
            guard let detailedRecipe = try? JSONDecoder().decode(DetailedRecipe.self, from: data) else {
                callback(false, nil)
                return
            }
            
            // If all verifications success return callback true & detailedRecipe
            callback(true, detailedRecipe)
        }
        
    }
    
}
