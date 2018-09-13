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
    func convertStringToStringArray(separator: CharacterSet) -> [String] {
        let convertedArray = self.components(separatedBy: separator)
        
        return convertedArray
    }
    
    func convertStringToStringSet(separator: CharacterSet) -> Set<String> {
        let convertedArray = self.components(separatedBy: separator)
        let convertedSet = Set(convertedArray)
        
        return convertedSet
    }
    
}
