//
//  YummlyURLStringTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 21/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import Reciplease

class YummlyURLStringTestCase: XCTestCase {
    
    // Query (q=kiwi+lemon) should be kiwi+lemon, the rest of the URL are constants
    func testGivenKiwiLemon_WhenInitYummlyURLString_ThenQueryParameterShouldBe_kiwi_lemon() {
        let ingredients = ["kiwi", "lemon"]
        
        let yummlyURLString = YummlyURLString(ingredients: ingredients)
        
        XCTAssertEqual(yummlyURLString.urlString, Constants.YummlyAPI.urlString + "kiwi+lemon")
    }

}