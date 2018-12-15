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
    private lazy var urlRequest = URLRequest(url: URL(string: urlString)!)
    override var urlString: String {
        return "FakeURLString"
    }
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        // These ingredients in array must be adapted if the Recipe.json is changed
        // You can find this in "criteria" and "q" keys
        super.init(ingredients: ["apple", "orange"])
    }
    
    func alamofireRequest(url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments,
                                                   response: httpResponse,
                                                   data: data,
                                                   error: error)
        
        callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
    
}
