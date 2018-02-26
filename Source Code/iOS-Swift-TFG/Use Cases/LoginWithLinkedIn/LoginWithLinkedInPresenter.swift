//
//  LoginWithLinkedInPresenter.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 3/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at Presenter
protocol LoginWithLinkedInEventHandler:class
{
    var viewModel : LoginWithLinkedInViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
}

// MARK: - Protocol to be defined at Presenter
protocol LoginWithLinkedInResponseHandler: class
{
    func authorizationCodeURLRequestDidFinish(urlRequest: URLRequest)
    func tokenRequestDidFinish(accessToken: String)
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class LoginWithLinkedInPresenter: NSObject, LoginWithLinkedInEventHandler, LoginWithLinkedInResponseHandler, UIWebViewDelegate {
    
    //MARK: relationships
    weak var viewController : LoginWithLinkedInViewUpdatesHandler!
    var interactor : LoginWithLinkedInRequestHandler!
    var wireframe : LoginWithLinkedInNavigationHandler!

    var viewModel = LoginWithLinkedInViewModel()
    
    //MARK: EventsHandler Protocol
    func handleViewWillAppear() {
    //When the ViewController will appears, it sends a event to the Presenter, and the Presenter request the AuthorizationCodeURLRequest to the Interactor.
       self.interactor.requestAuthorizationCodeURLRequest()
    }
    
    func handleViewWillDisappear() {
        //TODO:
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url!
        print("URL recieved: \(url)")
        
        if url.host! == "jns.ios-swift-tfg.linkedin.oauth" {

            if url.absoluteString.range(of: "code") != nil {
                let queryItems = URLComponents(string: url.absoluteString)?.queryItems
                let code = queryItems?.filter({$0.name == "code"}).first
                
                //TODO: Verify that status recieved is equals to status sended.
                self.interactor.requestAccesTokenSending(authorizationCode: (code?.value)!)
            }
        }
        return true
    }

    
    //MARK: ResponseHandler Protocol
    
    func authorizationCodeURLRequestDidFinish(urlRequest: URLRequest){
        self.viewController.updateWebView(urlRequest: urlRequest)
    }
    
    func tokenRequestDidFinish(accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "LIAccessToken")
        UserDefaults.standard.synchronize()
        
        self.wireframe.presentWelcomeModule()
    }
    

    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillProgress(){}
    // func somethingRequestDidProgress(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}

}
