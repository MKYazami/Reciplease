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
    
    override func request(url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        fakeResponse.fakeRequest(fakeResponse: fakeResponse, urlString: urlString, callback: callback)
    }
    
}
