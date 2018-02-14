//
//  LoginTarget.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 3/6/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit
import Moya


class LoginRequestDTO: TargetType, AccessTokenAuthorizable {
    
    //MARK: Parameters
    let grantType = "authorization_code"
    let authorizationCode: String
    let redirectURL = "https://jns.ios-swift-tfg.linkedin.oauth/oauth"
    let linkedInClientKey = "77fzljdw85kkb2"
    let linkedInClientSecret = "o5Drb62VllgdamWb"
    
    
    //MARK: Init
    init(authorizationCode: String) {
        self.authorizationCode = authorizationCode
    }
    
    //MARK: TargetType Protocol
    public var baseURL: URL { return URL(string: "https://www.linkedin.com/uas/oauth2")! }
    
    
    public var path: String {
        return "accessToken"
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var parameters: [String: Any]? {
        return ["grant_type":grantType, "code":authorizationCode, "redirect_uri":redirectURL, "client_id":linkedInClientKey, "client_secret": linkedInClientSecret]
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
    
    public var shouldAuthorize: Bool {
        return false
    }
}
