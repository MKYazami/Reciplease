//
//  RecipeServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 29/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeServiceTestCase: XCTestCase {
    
    /// Contains the time interval for waiting expectation
    private var httpRequestExpectationTimeOut: TimeInterval {
        // Set the expectations time out in seconds for HTTP requests
        return 5
    }
    
    // MARK: downloadRecipe Tests
    
    func testDownloadRecipeShouldSuccessIfNoErrorAndCorrectData() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: YummlyURLString(ingredients: ["orange"]))
        
        alamoSession.downloadRecipe { ( success, recipe) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test for status code response is different of 200
    func testDownloadRecipeShouldFailedIfBadResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWith500StatusCode())
        
        alamoSession.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test of an inexistent & fake URL
    func testDownloadRecipeShouldFailedIfFakeURL() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWithFakeURL())
        
        alamoSession.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test if JSON decoding failed in case of a different JSON response than expected
    func testDownloadRecipeShouldFailedIfFakeJSONResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWithFakeJSONResponse())
        
        alamoSession.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test if `matches` array, which contains the recipes results is empty
    func testDownloadRecipeShouldFailedIfEmptyMatchesResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWithEmptyMatchesArray())
        
        alamoSession.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // MARK: downloadDetailedRecipe Tests
    
    func testDownloadDetailedRecipeShouldSuccessIfNoErrorAndCorrectData() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: YummlyDetailedURLString(recipeID: "Kiwi-Capiroska-1564214"))
        
        alamoSession.downloadDetailedRecipe { (success, detailedRecipe) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(detailedRecipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test of an inexistent & fake URL
    func testDownloadDetailedRecipeShouldFailedIfFakeURL() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWithFakeURL())
        
        alamoSession.downloadDetailedRecipe { (success, detailedRecipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detailedRecipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test for status code response is different of 200
    func testDownloadDetailedRecipeShouldFailedIfBadResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWith500StatusCode())
        
        alamoSession.downloadDetailedRecipe { (success, detailedRecipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detailedRecipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
    
    // Test if JSON decoding failed in case of a different JSON response than expected
    func testDownloadDetailedRecipeShouldFailedIfFakeJSONResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let alamoSession = RecipeService(urlStringType: URLStringTypeWithFakeJSONResponse())
        
        alamoSession.downloadDetailedRecipe { (success, detailedRecipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detailedRecipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: httpRequestExpectationTimeOut)
    }
}
