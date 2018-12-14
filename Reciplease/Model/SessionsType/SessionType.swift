//
//  SessionType.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import Alamofire

/// This protocol force the types to adopt a minimum required properties to get url string for recipes results
protocol SessionType {    
    var urlString: String { get }
}

extension SessionType {
    
    /// Allows to make network request with Alamofire
    ///
    /// - Parameters:
    ///   - url: url for request
    ///   - callback: callback which we check and handle data response
    func alamofireRequest(url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { (responseData) in
            callback(responseData)
        }
    }
    
}
