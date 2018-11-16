//
//  Constants.swift
//  Reciplease
//
//  Created by Mehdi on 05/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

/// This structure centralizes all the constants useful to the project
struct Constants {
    
    struct TableViewCells {
        
        /// Contains nib name of Recipe Table View
        static var recipeTableViewCellNib: String {
            return "RecipeTableViewCell"
        }
        
        /// Contains cell id of Recipe Cell
        static var recipeCellId: String {
            return "recipeCell"
        }
    }
    
    struct Segue {
        static var toRecipesResults: String {
            return "segueToRecipesResults"
        }
        
        static var toDetailedRecipe: String {
            return "segueToDetailedRecipe"
        }
        
        static var toFavoriteDetail: String {
            return "fromFavoritesListToFavoriteDetails"
        }
    }
    
    struct AlertMessage {
        static var networkErrorTitle: String {
            return "Network Problem!"
        }
        
        static var networkErrorDescription: String {
            return "Please check your connection or try again later"
        }
        
        static var saveRecipeErrorTitle: String {
            return "Recipe not saved!"
        }
        
        static var saveRecipeErrorDescription: String {
            return "Impossible to save recipe, try later"
        }
        
        static var deleteRecipeErrorTitle: String {
            return "Error to delete"
        }
        
        static var deleteRecipeErrorDescription: String {
            return "Imposible to remove recipe from favorites"
        }
        
        static var getDirectionsErrorTitle: String {
            return "Impossible to get directions!"
        }
        
        static var getDirectionsErrorDescription: String {
            return "Try later or with another recipe"
        }
        
        static var getDetailedRecipeErrorTitle: String {
            return "Impossible to get detailed recipe"
        }
        
        static var getDetailedRecipeErrorDescription: String {
            return "A problem has occurred and it is impossible to get the recipe detail"
        }
    }
    
    struct YummlyAPI {
        
        // MARK: Base URL & URL parameters keys
        private static let baseURL = "https://api.yummly.com/v1/api/recipes?"
        private static let appId = "_app_id="
        private static let appKey = "&_app_key="
        private static let query = "&q="
        
        // MARK: URL parameters values
        private static let appIdValue = "23631517"
        private static let appKeyValue = "a05732d6cc8f8bf91dc608a2691dc2f8"
        
        // Exemple of Full URL
        // https://api.yummly.com/v1/api/recipes?_app_id=23631517&_app_key=a05732d6cc8f8bf91dc608a2691dc2f8&q=apple+fish
        
        /// URL string constructed without query values
        static var urlString: String {
            return baseURL + appId + appIdValue + appKey + appKeyValue + query
        }
        
    }
    
    struct YummlyDetailedAPI {
        
        // MARK: Base URL & URL parameters keys
        private static let baseURL = "https://api.yummly.com/v1/api/recipe/"
        static let appId = "?_app_id="
        static let appKey = "&_app_key="
        
        // MARK: URL parameters values
        static let appIdValue = "23631517"
        static let appKeyValue = "a05732d6cc8f8bf91dc608a2691dc2f8"
        
        // Exemple of Full URL
        // https://api.yummly.com/v1/api/recipe/Yogurts-2055931?_app_id=23631517&_app_key=a05732d6cc8f8bf91dc608a2691dc2f8
        
        /// URL string constructed without recipe id
        static var baseURLString: String {
            return baseURL
        }
        
    }
    
}
