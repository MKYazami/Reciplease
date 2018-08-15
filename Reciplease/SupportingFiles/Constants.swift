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
    
}
