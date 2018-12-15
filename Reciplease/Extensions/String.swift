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
    /// - Returns: string array
    func convertStringToStringArray(separators: CharacterSet) -> [String] {
        let convertedArray = self.components(separatedBy: separators)
        
        return convertedArray
    }
    
    /// Allows to remove deplicated string to unique string array (Set)
    ///
    /// - Parameter separator: separator caracterset in the form of string array as ["," , " ", "-"]
    /// - Returns: string set
    func convertStringToStringSet(separators: CharacterSet) -> Set<String> {
        let convertedArray = self.components(separatedBy: separators)
        let convertedSet = Set(convertedArray)
        
        return convertedSet
    }
    
}
