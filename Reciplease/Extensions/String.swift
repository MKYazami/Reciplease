//
//  String.swift
//  Reciplease
//
//  Created by Mehdi on 19/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

extension String {
    
    /// Allows to covert a string elements separated by CharacterSet => Exemple: if you wish to split the string by space into array you set in separator parameter [" "]
    ///
    /// - Parameters:
    ///   - separator: separator caracterset in the form of string array as ["," , " ", "-"]
    /// - Returns: String array
    func convertStringToStringArrayString(separator: CharacterSet) -> [String] {
        let convertedArray = self.components(separatedBy: separator)
        
        return convertedArray
    }
    
}

extension Array {
    
    /// Allows to remove duplicated items in an array of string
    ///
    /// - Parameter stringArray: Array to be purged from duplications
    /// - Returns: Array with unique items
    static func removeDuplicatedStringArrayItem(stringArray: [String]) -> [String] {
        // Removing duplicated items by converting to set string
        let uniqueItems = Set<String>(stringArray)
        
        // Convert back to array
        let uniqueItemsStringArray = [String](uniqueItems)
        
        return uniqueItemsStringArray
    }
    
}
