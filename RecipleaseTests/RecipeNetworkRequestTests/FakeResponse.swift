//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by Mehdi on 14/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import Alamofire

struct FakeResponse {
    
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
    
    init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }
    
}

extension FakeResponse {
    
    /// Allows to make fake http request by avoiding network http request
    ///
    /// - Parameters:
    ///   - fakeResponse: fake responses
    ///   - urlString: url string
    ///   - callback: callback inside we check and handle data responses
    /// - This method is used for unit tests 
    func fakeRequest(fakeResponse: FakeResponse, urlString: String, callback: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments,
                                                   response: httpResponse,
                                                   data: data,
                                                   error: error)
        
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
    
}
