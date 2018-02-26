//
//  SignInInteractor.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol SignInRequestHandler:class
{
    // func requestSomething()
    // func requestUser(id:String)
}


// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class SignInInteractor: SignInRequestHandler
{
    //MARK: Relationships
    weak var presenter : SignInResponseHandler?
    
    //MARK: RequestHandler Protocol
    //func requestSomething(){}
}

