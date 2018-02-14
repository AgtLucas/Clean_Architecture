//
//  ProfileTarget.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 12/06/2017.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit
import Moya

class ProfileRequestDTO: TargetType {

    //MARK: Parameters
    let formatType = "json"
    
    //MARK: Init
    init() {}
    
    //MARK: TargetType Protocol
    public var baseURL: URL { return URL(string: "https://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name,formatted-name,picture-url)")! }
    
    
    public var path: String {
        return ""
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return ["format":formatType]
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
