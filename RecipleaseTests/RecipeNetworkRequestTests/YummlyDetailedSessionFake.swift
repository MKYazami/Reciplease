//
//  YummlyDetailedSessionFake.swift
//  RecipleaseTests
//
//  Created by Mehdi on 15/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class YummlyDetailedSessionFake: YummlyDetailedSession {
    
    private let fakeResponse: FakeResponse
    private lazy var urlRequest = URLRequest(url: URL(string: urlString)!)
    override var urlString: String {
        return "FakeURLString"
    }
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        // This recipe id must be adapted if the DetailedRecipe.json is changed
        // You can find this information "id" key
        super.init(recipeID: "Apple_-Pear_-and-Orange-Quick-Pops-608966")
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
