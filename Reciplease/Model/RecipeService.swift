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
    
    init(urlStringType: URLStringType, recipeSession: URLSession = URLSession(configuration: .default)) {
        self.urlStringType = urlStringType
        self.recipeSession = recipeSession
    }
    
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
                callback(false, nil)
                return
            }
            
            // If all verifications success return callback true & recipe
            callback(true, recipe)
        }
    }
    
}
