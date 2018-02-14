//
//  LaunchScreenPresenter.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Presenter
protocol LaunchScreenEventHandler:class
{
    var viewModel : LaunchScreenViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
}

// MARK: - Protocol to be defined at Presenter
protocol LaunchScreenResponseHandler: class
{
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
    func loginStatusRequestDidFinish(isUserLogged: Bool) -> Void
    
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class LaunchScreenPresenter: LaunchScreenEventHandler, LaunchScreenResponseHandler {
    
    //MARK: relationships
    weak var viewController : LaunchScreenViewUpdatesHandler?
    var interactor : LaunchScreenRequestHandler!
    var wireframe : LaunchScreenNavigationHandler!

    var viewModel = LaunchScreenViewModel()
    
    //MARK: EventsHandler Protocol
    func handleViewWillAppear() {
        self.interactor.requestLoginStatus()
    }
    
    func handleViewWillDisappear() {
        //TODO:
    }
    
    //MARK: ResponseHandler Protocol
    
    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillProgress(){}
    // func somethingRequestDidProgress(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}
    
    func loginStatusRequestDidFinish(isUserLogged: Bool) -> Void{
        if(!isUserLogged){
            self.wireframe.presentSignInModule()
        }else{
            self.wireframe.presentWelcomeModule()
        }
    }

}
