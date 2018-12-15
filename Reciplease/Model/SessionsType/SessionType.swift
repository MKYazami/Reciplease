//
//  SessionType.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import Alamofire

/// This protocol force the types to adopt a minimum required properties to get url string & http request for recipes results
protocol SessionType {
    
    var urlString: String { get }
    
    /// Allows to make http request with Alamofire
    ///
    /// - Parameters:
    ///   - url: url for request
    ///   - callback: callback which we check and handle data response
    /// - This method is abstract in order to be overrided in sub classes as for unit tests purpose
    /// - And you can reuse it in sub classes
    func request(url: URL, callback: @escaping (DataResponse<Any>) -> Void)
    
}

extension SessionType {
    
    /// Allows to make network request with Alamofire
    ///
    /// - Parameters:
    ///   - url: url for request
    ///   - callback: callback which we check and handle data response
    /// - When you conform to SessionType protocol and you need to use Alamofire request in production,
    /// - You should implement this method inside request method (declared in SessionType protocol)
    func alamofireRequest(url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { (responseData) in
            callback(responseData)
        }
    }
    
}
