//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Mehdi on 14/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct FakeResponseData {
    
    // MARK: FAKE RESPONSE
    private static let url = URL(string: "https://www.google.fr")!
    static let responseOK = HTTPURLResponse(url: url,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: url,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)!
    
    // MARK: FAKE DATA
    static var recipeData: Data {
        let bundle = Bundle(for: NetworkError.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var detailedRecipeData: Data {
        let bundle = Bundle(for: NetworkError.self)
        let url = bundle.url(forResource: "DetailedRecipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "error".data(using: .utf8)!
    
    // MARK: FAKE ERROR
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
}
