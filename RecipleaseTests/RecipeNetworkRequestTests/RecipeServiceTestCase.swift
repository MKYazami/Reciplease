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
    private var expectationTimeOut: TimeInterval {
        // Set the expectations time out in seconds
        return 0.1
    }
    
    // MARK: downloadRecipe Tests
    
    func testDownloadRecipeShouldFailedIfNoResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: nil,
                                        data: FakeResponseData.recipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlySessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }
    
    func testDownloadRecipeShouldFailedIfError() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.recipeData,
                                        error: FakeResponseData.networkError)
        
        let recipeService = RecipeService(sessionType: YummlySessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }

    func testDownloadRecipeShouldFailedIfIncorrectResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO,
                                        data: FakeResponseData.recipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlySessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)

    }
    
    func testDownloadRecipeShouldFailedIfOtherDataThanExpected() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        // Using detailedRecipeData to test JSON decoder because expected recipeData
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.detailedRecipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlySessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
    }
    
    func testDownloadRecipeShouldFailedIfEmptyMatchesResponse() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        // matches is key that contains all recipes in json file
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.recipe0MatchData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlySessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
    }
    
    func testDownloadRecipeShouldSuccessIfNoErrorAndCorrectData() {
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.recipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlySessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadRecipe { ( success, recipe) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
    }
    
    // MARK: downloadDetailedRecipe Tests Detailed
    
    func testDownloadDetailedRecipeShouldFailedIfNoResponse() {
        
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: nil,
                                        data: FakeResponseData.detailedRecipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlyDetailedSessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadDetailedRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }
    
    func testDownloadDetailedRecipeShouldFailedIfError() {
        
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.detailedRecipeData,
                                        error: FakeResponseData.networkError)
        
        let recipeService = RecipeService(sessionType: YummlyDetailedSessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadDetailedRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }
    
    func testDownloadDetailedRecipeShouldFailedIfIncorrectResponse() {
        
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO,
                                        data: FakeResponseData.detailedRecipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlyDetailedSessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadDetailedRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }
    
    func testDownloadDetailedRecipeShouldFailedIfOtherDataThanExpected() {
        
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        // Using recipeData to test JSON decoder because expected detailedRecipeData
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.recipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlyDetailedSessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadDetailedRecipe { ( success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }
    
    func testDownloadDetailedRecipeShouldSuccessIfNoErrorAndCorrectData() {
        
        let expectation = XCTestExpectation(description: "Wait for queue change in Alamofire")
        
        // Using recipeData to test JSON decoder because expected detailedRecipeData
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.detailedRecipeData,
                                        error: nil)
        
        let recipeService = RecipeService(sessionType: YummlyDetailedSessionFake(fakeResponse: fakeResponse))
        
        recipeService.downloadDetailedRecipe { ( success, recipe) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: expectationTimeOut)
        
    }
    
}
