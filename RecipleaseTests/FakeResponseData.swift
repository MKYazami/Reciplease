//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Mehdi on 27/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    // MARK: Fake Data
    
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        
        return data
    }
    
    static let recipeIncorrectData = "incorrectData".data(using: .utf8)!
    
    // MARK: Fake Response
    
    static let reponseOK = HTTPURLResponse(url: URL(string: "https://developer.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let reponseKO = HTTPURLResponse(url: URL(string: "https://developer.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: Recipe Error
    class recipeError: Error {}
    static let error = recipeError()
}
