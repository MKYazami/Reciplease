//
//  StringExtensionTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 15/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease

class StringExtensionTestCase: XCTestCase {
    
    // MARK: TESTS convertStringToStringArray METHOD
    func testGiven4StringWordsSeparetedByCharacterSet_WhenConvertToStringArray_ThenWordsSouldBeInStringArrayWith4Items() {
        // Given
        let words = "lemon, orange - fish _ kiwi"
        
        // When
        let stringArray = words.convertStringToStringArray(separators: [",", "-", "_"])
        
        // Then
        XCTAssertEqual(stringArray.count, 4)
        
    }
    
    func testGiven2StringWordsSeparetedBySpace_WhenConvertToStringArray_ThenWordsSouldBeInStringArrayWith2Items() {
        // Given
        let words = "coffee cinnamon"
        
        // When
        let stringArray = words.convertStringToStringArray(separators: [" "])
        
        // Then
        XCTAssertEqual(stringArray.count, 2)
        
    }
    
    // MARK: TESTS convertStringToStringSet METHOD
    func testGiven6StringWordsWith2DuplicationsSeparetedByCharacterSet_WhenConvertToStringSet_ThenDuplicatedWordsSouldBeRemovedInStringSetWith4Items() {
        // Given
        let words = "cat,dog_lion-cat_tiger,dog"
        
        // When
        let stringSet = words.convertStringToStringSet(separators: [",", "-", "_"])
        
        // Then
        XCTAssertEqual(stringSet.count, 4, "6 words when removing 2 duplicated it remains 4")
        
    }
    
    func testGiven6StringWordsWith2DuplicationsSeparetedBySpace_WhenConvertToStringSet_ThenDuplicatedWordsSouldBeRemovedInStringSetWith4Items() {
        // Given
        let words = "cat dog lion cat tiger dog"
        
        // When
        let stringSet = words.convertStringToStringSet(separators: [" "])
        
        // Then
        XCTAssertEqual(stringSet.count, 4, "6 words when removing 2 duplicated it remains 4")
        
    }

}
