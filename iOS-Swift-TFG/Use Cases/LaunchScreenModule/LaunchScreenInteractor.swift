//
//  LaunchScreenInteractor.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol LaunchScreenRequestHandler:class
{
    // func requestSomething()
    // func requestUser(id:String)
    func requestLoginStatus() -> Void
}


// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class LaunchScreenInteractor: LaunchScreenRequestHandler
{
    //MARK: Relationships
    weak var presenter : LaunchScreenResponseHandler?
    
    //MARK: RequestHandler Protocol
    //func requestSomething(){}
    
    
    func requestLoginStatus() -> Void {
        
        if((UserDefaults.standard.string(forKey: "profileName")) != nil){
            presenter?.loginStatusRequestDidFinish(isUserLogged: true)
        }else{
            presenter?.loginStatusRequestDidFinish(isUserLogged: false)
        }
    }
}

