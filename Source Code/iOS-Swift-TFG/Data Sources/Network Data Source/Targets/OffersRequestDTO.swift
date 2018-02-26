//
//  OffersRequestDTO.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit
import Moya

class OffersRequestDTO: TargetType {

    
    //MARK: Parameters
    let query: String
    let province: String
    // TODO - "page", "maxResults" for lazy load
    
    
    //MARK: Init
    init(query: String, province:String) {
        self.query = query
        self.province = province
    }
    
    //MARK: TargetType Protocol
    public var baseURL: URL { return URL(string: "https://api.infojobs.net/api/1")! }
    
    
    public var path: String {
        return "/offer"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return["q": query,"province":province]
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return "Sample data".data(using:String.Encoding.utf8)!
    }
    
    public var task: Task {
        return .request
    }

    
}
