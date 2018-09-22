//
//  RecipeTestCase.swift
//  RecipleaseTests
//
//  Created by Mehdi on 21/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // MARK: convertSecondsToMinutesOrHours Tests
    func testGivenTimeInSecondsIs60_WhenConvertToMinutes_ThenShouldReturns_1m() {
        let seconds = 60
        
        let minutes = Recipe.convertSecondsToMinutesOrHours(numberOfSeconds: seconds)
        
        XCTAssertEqual(minutes, "1m")
    }
    
    func testGivenTimeInSecondsIs3600_WhenConvertToHours_ThenShouldReturns_1h0() {
        let seconds = 3600
        
        let minutes = Recipe.convertSecondsToMinutesOrHours(numberOfSeconds: seconds)
        
        XCTAssertEqual(minutes, "1h0")
    }
    
    // MARK: defineRatingStars Tests
    func testGivenRating1_WhenDefineRatingStars_ThenShouldReturns_rating1Of5() {
        let rating = 1
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.rating1Of5.rawValue)
    }
    
    func testGivenRating2_WhenDefineRatingStars_ThenShouldReturns_rating2Of5() {
        let rating = 2
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.rating2Of5.rawValue)
    }
    
    func testGivenRating3_WhenDefineRatingStars_ThenShouldReturns_rating3Of5() {
        let rating = 3
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.rating3Of5.rawValue)
    }
    
    func testGivenRating4_WhenDefineRatingStars_ThenShouldReturns_rating4Of5() {
        let rating = 4
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.rating4Of5.rawValue)
    }
    
    func testGivenRating5_WhenDefineRatingStars_ThenShouldReturns_rating5Of5() {
        let rating = 5
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.rating5Of5.rawValue)
    }
    
    func testGivenRating6_WhenDefineRatingStars_ThenShouldReturns_noRating() {
        let rating = 0
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.noRating.rawValue)
    }
    
    func testGivenRatingIsNil_WhenDefineRatingStars_ThenShouldReturns_noRating() {
        let rating: Int? = nil
        
        let imageName = Recipe.defineRatingStars(rating: rating)
        
        XCTAssertEqual(imageName, RatingStarsImagesNames.noRating.rawValue)
    }
    
}
