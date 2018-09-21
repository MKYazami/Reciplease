//
//  Recipe.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

// MARK: Recipe structs
struct Recipe: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    let rating: Int?
    let imageUrlsBySize: ImageURLSize
    let recipeName: String
    let ingredients: [String]
    let totalTimeInSeconds: Int
    let recipeID: String
    
    private enum CodingKeys: String, CodingKey {
        case recipeID = "id"
        case rating, imageUrlsBySize, recipeName, ingredients, totalTimeInSeconds
    }
}

struct ImageURLSize: Decodable {
    let imageSize90: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageSize90 = "90"
    }
}

// MARK: Detailed recipe structs
struct DetailedRecipe: Decodable {
    let name: String
    let ingredientLines: [String]
    let source: Source
    let images: [URLImages]
    let rating: Int
    let totalTimeInSeconds: Int
}

struct Source: Decodable {
    let sourceRecipeUrl: String
}

struct URLImages: Decodable {
    let hostedLargeUrl: String
}

// MARK: Methods Recipe
extension Recipe {
    
    /// Convert number of seconds in hours & mintes OR rounded minutes for time less than 1 hour
    ///
    /// - Parameter numberOfSeconds: number of seconds to convert
    /// - Returns: number of minutes OR hours & minutes
    static func convertSecondsToMinutesOrHours(numberOfSeconds: Int) -> String {
        
        let secondsInDouble = Double(numberOfSeconds)
        
        if numberOfSeconds > 3598 {
            let hoursAndMinutes = UnitDuration.hours.converter.value(fromBaseUnitValue: secondsInDouble)
            let minutesFromHours = Float(hoursAndMinutes).truncatingRemainder(dividingBy: 1)
            let hours = Int(hoursAndMinutes)
            
            return String(hours) + "h" + String(format: "%.0f", minutesFromHours * 60)
        } else {
            let minutes = UnitDuration.minutes.converter.value(fromBaseUnitValue: secondsInDouble)
            
            return String(Int(round(minutes))) + "m"
        }
        
    }
    
    /// Allows to get the image name depending on received rating
    ///
    /// - Parameter rating: rating of recipe normaly between 1 and 5 coming from remote API
    /// - Returns: name of image to define the rating level
    static func defineRatingStars(rating: Int?) -> String {
        
        guard let rating = rating else { return RatingStarsImagesNames.noRating.rawValue }
        
        switch rating {
        case 1:
            return RatingStarsImagesNames.rating1Of5.rawValue
        case 2:
            return RatingStarsImagesNames.rating2Of5.rawValue
        case 3:
            return RatingStarsImagesNames.rating3Of5.rawValue
        case 4:
            return RatingStarsImagesNames.rating4Of5.rawValue
        case 5:
            return RatingStarsImagesNames.rating5Of5.rawValue
        default:
            return RatingStarsImagesNames.noRating.rawValue
        }
        
    }
    
}
