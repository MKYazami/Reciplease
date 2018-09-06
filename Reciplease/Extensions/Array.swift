//
//  Array.swift
//  Reciplease
//
//  Created by Mehdi on 06/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

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
