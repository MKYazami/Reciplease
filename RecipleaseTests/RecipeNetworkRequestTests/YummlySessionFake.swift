//
//  YummlySessionFake.swift
//  RecipleaseTests
//
//  Created by Mehdi on 15/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class YummlySessionFake: YummlySession {
    
    private let fakeResponse: FakeResponse
    override var urlString: String {
        return "FakeURLString"
    }
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        // These ingredients in array must be adapted if the Recipe.json is changed
        // You can find this in "criteria" and "q" keys
        super.init(ingredients: ["apple", "orange"])
    }
    
    override func request(url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        fakeResponse.fakeRequest(fakeResponse: fakeResponse, urlString: urlString, callback: callback)
    }
    
}
