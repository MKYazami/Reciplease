//
//  URLStringType.swift
//  Reciplease
//
//  Created by Mehdi on 15/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

/// This protocol force the types to adopt a minimum required properties to get url string for recipes results
protocol URLStringType {    
    var urlString: String { get }
}
