//
//  YummlyDetailedSessionTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 22/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import Reciplease

class YummlyDetailedSessionTestCase: XCTestCase {
    
    // The recipe ID is Kiwi-Capiroska-1564214
    func testGivenRecipeIDIsKiwi_Capiroska_1564214_WhenInitYummlyDetailedURLString_ThenRecipeIDParameterShouldBe_Kiwi_Capiroska_1564214() {
        let recipeID = "Kiwi-Capiroska-1564214"
        
        let yummlyDetailedURLString = YummlyDetailedSession(recipeID: recipeID)
        
        typealias YummlyDetailed = Constants.YummlyDetailedAPI
        XCTAssertEqual(yummlyDetailedURLString.urlString, YummlyDetailed.baseURLString + recipeID + YummlyDetailed.appId + YummlyDetailed.appIdValue + YummlyDetailed.appKey + YummlyDetailed.appKeyValue)
    }
    
}
