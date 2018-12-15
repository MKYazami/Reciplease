//
//  ArrayExtensionTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 15/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease

class ArrayExtensionTestCase: XCTestCase {

    // MARK: TEST removeDuplicatedStringArrayItem METHOD
    func testGivenStringArrayWithDuplicatedItem_WhenRemoveDuplicatedItems_ThenStringArrayShouldBeWithUniqueItems() {
        // Given
        let arrayWithDuplications = ["runway", "tower", "runway", "taxiway", "airway", "taxiway"]
        
        // When
        let arrayWithoutDuplications = [String].removeDuplicatedStringArrayItem(stringArray: arrayWithDuplications)
        
        // Then
        XCTAssertEqual(arrayWithoutDuplications.count, 4,
                       "6 items minus 2 duplicated items should equals 4")
    }

}
