//
//  Recipe.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct Recipe: Decodable {
    var matches: [Match] = []
}

struct Match: Decodable {
    
    var imageUrlsBySize: ImageURLSize
    var recipeName: String
    var ingredients: [String]
    var timePreparationInSeconds: Int
    
    private enum CondingKeys: String, CodingKey {
        case imageUrlsBySize = "imageUrlsBySize"
        case recipeName = "recipeName"
        case ingredients = "ingredients"
        case timePreparationInSeconds = "totalTimeInSeconds"
    }
    
}

struct ImageURLSize: Decodable {
    var imageSize90: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageSize90 = "90"
    }
}
