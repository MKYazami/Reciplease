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
    var totalTimeInSeconds: Int
    
}

struct ImageURLSize: Decodable {
    var imageSize90: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageSize90 = "90"
    }
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
    
}
