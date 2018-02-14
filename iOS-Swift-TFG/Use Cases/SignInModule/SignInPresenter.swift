//
//  SignInPresenter.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Presenter
protocol SignInEventHandler:class
{
    var viewModel : SignInViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
    func handleSignInButtonPressedEvent()
}

// MARK: - Protocol to be defined at Presenter
protocol SignInResponseHandler: class
{
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class SignInPresenter: SignInEventHandler, SignInResponseHandler {
    
    //MARK: relationships
    weak var viewController : SignInViewUpdatesHandler?
    var interactor : SignInRequestHandler!
    var wireframe : SignInNavigationHandler!

    var viewModel = SignInViewModel()
    
    //MARK: EventsHandler Protocol
    func handleViewWillAppear() {
        //TODO:
    }
    
    func handleViewWillDisappear() {
        //TODO:
    }
    
    func handleSignInButtonPressedEvent() {
        self.wireframe.presentLoginWithLinkedInModule()
    }
    
    //MARK: ResponseHandler Protocol
    
    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillProgress(){}
    // func somethingRequestDidProgress(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}

}
