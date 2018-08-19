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
    ///   - stringToConvert: The string to convert into string array
    ///   - separator: separator caracterset in the form of string array as ["," , " ", "-"]
    /// - Returns:
    private func convertStringToStringArrayString(stringToConvert: String, separator: CharacterSet) -> [String] {
        let convertedArray = stringToConvert.components(separatedBy: separator)
        
        return convertedArray
    }
    
}
