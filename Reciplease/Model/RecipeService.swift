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
    
    private let urlStringType: URLStringType
    private let recipeSession: URLSession
    
    /// Init the recipe service with urlStringType and recipeSession which by default is ".default" if we need a specific session we set it in the init in recipeSession
    ///
    /// - Parameters:
    ///   - urlStringType: URL String Type
    ///   - recipeSession: URLSession type
    init(urlStringType: URLStringType, recipeSession: URLSession = URLSession(configuration: .default)) {
        self.urlStringType = urlStringType
        self.recipeSession = recipeSession
    }
    
    /// Download recipes from remote API
    ///
    /// - Parameter callback: Contains 2 parameters 1 Bool for to set success and the second Recipe to get recipes
    func downloadRecipe(callback: @escaping (Bool, Recipe?) -> Void) {
        let urlString = urlStringType.urlString
        Alamofire.request(urlString).response { (response) in
            
            // Check if data ≠ nil & no error
            guard let data = response.data, response.error == nil else {
                callback(false, nil)
                return
            }
            
            // Check correct response
            guard let response = response.response, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            // Decode JSON data
            guard let recipe = try? JSONDecoder().decode(Recipe.self, from: data) else {
                print("Problem of decodage")
                callback(false, nil)
                return
            }
            
            // If all verifications success return callback true & recipe
            callback(true, recipe)
        }
    }
    
    /// Download detailed recipes from remote API
    ///
    /// - Parameter callback: Contains 2 parameters 1 Bool for set success and the second DetailedRecipe to get the detail of recipes
    func downloadDetailedRecipe(callback: @escaping (Bool, DetailedRecipe?) -> Void) {
        let urlString = urlStringType.urlString
        
        Alamofire.request(urlString).response { (response) in
            // Check if data ≠ nil & no error
            guard let data = response.data, response.error == nil else {
                callback(false, nil)
                return
            }
            
            // Check correct response
            guard let response = response.response, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            // Decode JSON data
            guard let detailedRecipe = try? JSONDecoder().decode(DetailedRecipe.self, from: data) else {
                print("Problem of decodage")
                callback(false, nil)
                return
            }
            
            // If all verifications success return callback true & detailedRecipe
            callback(true, detailedRecipe)
        }
    }
    
}
