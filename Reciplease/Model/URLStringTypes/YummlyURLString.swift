//
//  YummlyURLString.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

struct YummlyURLString: URLStringType {
    
    /// To complete API Call Add Query Values
    var urlString: String {
        return Constants.YummlyAPI.urlString
    }
}
