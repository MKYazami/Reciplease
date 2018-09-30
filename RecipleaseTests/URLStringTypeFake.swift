//
//  URLStringTypeMock.swift
//  RecipleaseTests
//
//  Created by Mehdi on 29/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//
// THIS FILE CONTAINS SOME URLStringType THAT ALLOW TO TEST THE APPLICATION IN DIFFERENTS CONTEXTS CONCERNING THE HTTP REQUESTS

import Foundation
@testable import Reciplease

/// This structure contains a fake URL as `Fake URL` to test a bad request
struct URLStringTypeWithFakeURL: URLStringType {
    var urlString: String {
        return "Fake URL"
    }
}

/// This structure contains status code response of 500
struct URLStringTypeWith500StatusCode: URLStringType {
    var urlString: String {
        return "https://httpbin.org/status/500"
    }
}

/// This structure contains a fake JSON response from expected APIs
struct URLStringTypeWithFakeJSONResponse: URLStringType {
    var urlString: String {
        return "https://httpbin.org/get"
    }
}

/// This structure contains URL to Yummly API in order to get empty matches array results which contains the recipes.
/// - The The way to get this result is to make a query with ‘q=12345678‘.
struct URLStringTypeWithEmptyMatchesArray: URLStringType {
    var urlString: String {
        return "https://api.yummly.com/v1/api/recipes?_app_id=23631517&_app_key=a05732d6cc8f8bf91dc608a2691dc2f8&q=12345678"
    }
}
