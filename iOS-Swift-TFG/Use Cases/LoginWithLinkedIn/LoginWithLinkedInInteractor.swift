//
//  LoginWithLinkedInInteractor.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 3/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import Moya
import Moya_ObjectMapper
import SwiftyJSON
import ObjectMapper

// MARK: - Protocol to be defined at Interactor
protocol LoginWithLinkedInRequestHandler:class
{
    func requestAuthorizationCodeURLRequest()
    func requestAccesTokenSending(authorizationCode: String)
    // func requestSomething()
    // func requestUser(id:String)
}


// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class LoginWithLinkedInInteractor: LoginWithLinkedInRequestHandler
{
    //MARK: Relationships
    weak var presenter : LoginWithLinkedInResponseHandler?
    
    var repository = NetworkRepository()
    
    
    // MARK: Constants
    
    let linkedInKey = "77fzljdw85kkb2"
    
    let linkedInSecret = "o5Drb62VllgdamWb"
    
    let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
    
    let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"
    
    //MARK: RequestHandler Protocol
    func requestAuthorizationCodeURLRequest() {
        // Specify the response type which should always be "code".
        let responseType = "code"
        
        // Set the redirect URL. Adding the percent escape characthers is necessary.
        let redirectURL = "https://jns.ios-swift-tfg.linkedin.oauth/oauth"
        
        // Create a random string based on the time interval (it will be in the form linkedin12345679).
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        
        // Set preferred scope.
        let scope = "r_basicprofile"
        
        // Create the authorization URL string.
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(linkedInKey)&"
        authorizationURL += "redirect_uri=\(String(describing: redirectURL))&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        
        print(authorizationURL)
        
        // Create a URL request and load it in the web view.
        
        let urlStr : NSString = authorizationURL.addingPercentEscapes(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as NSString
        let url : NSURL = NSURL(string: urlStr as String)!
        
        
        let request: NSURLRequest = NSURLRequest(url: url as URL)
        
        self.presenter?.authorizationCodeURLRequestDidFinish(urlRequest: request as URLRequest)
    }
    
    
    
    func requestAccesTokenSending(authorizationCode: String) {
        
        self.repository.fetchAccesTokenSending(authorizationCode: authorizationCode, handleAccessTokenResponseDTO: { (accessTokenResponseDTO) in
            switch(accessTokenResponseDTO){
            case let .success(accessTokenDTO: accessTokenDTO):
                //Create the Entity from DTO adding business logic.
                
                self.presenter?.tokenRequestDidFinish(accessToken: accessTokenDTO.accessToken!)
                
            case let .fail(accesTokenFailDTO: accesTokenFailDTO):
                break
            }
        })
        
        
        
    }
    
}

