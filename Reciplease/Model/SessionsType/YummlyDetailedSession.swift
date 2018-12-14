//
//  YummlyDetailedSession.swift
//  Reciplease
//
//  Created by Mehdi on 15/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

/// Allows to define URL String for detailed recipes in Yummly API
class YummlyDetailedSession: SessionType {
    private let recipeID: String
    
    init(recipeID: String) {
        self.recipeID = recipeID
    }
    
    var urlString: String {
        typealias YummlyDetailed = Constants.YummlyDetailedAPI
        
        return YummlyDetailed.baseURLString + recipeID + YummlyDetailed.appId + YummlyDetailed.appIdValue + YummlyDetailed.appKey + YummlyDetailed.appKeyValue
    }
}
