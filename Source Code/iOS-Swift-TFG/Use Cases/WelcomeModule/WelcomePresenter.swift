//
//  WelcomePresenter.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 10/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at Presenter
protocol WelcomeEventHandler:class
{
    var viewModel : WelcomeViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
    func handleSearchOffersPressed()
}

// MARK: - Protocol to be defined at Presenter
protocol WelcomeResponseHandler: class
{
    func profileRequestDidFinish(profileDTO: ProfileDTO)
    func beaconRepositoryDidRangeBeacon(beaconID: String)
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class WelcomePresenter: WelcomeEventHandler, WelcomeResponseHandler {
    
    //MARK: relationships
    weak var viewController : WelcomeViewUpdatesHandler?
    var interactor : WelcomeRequestHandler!
    var wireframe : WelcomeNavigationHandler!

    var viewModel = WelcomeViewModel()
    
    //MARK: EventsHandler Protocol
    func handleViewWillAppear() {
        //TODO:
        
        self.interactor.requestProfile()
        self.interactor.setupBeacons()
    }
    
    func handleViewWillDisappear() {
        //TODO:
    }
    
    func handleSearchOffersPressed() {
        self.wireframe.presentOffersModule()
    }
    
    //MARK: ResponseHandler Protocol
    
    func profileRequestDidFinish(profileDTO: ProfileDTO){
        self.viewController?.updateProfileView(profileName: profileDTO.firstName! + " " + profileDTO.lastName!, profileURLImage: profileDTO.pictureURL!)
        //TODO:
    }
    
    func beaconRepositoryDidRangeBeacon(beaconID: String) {
        self.viewController?.showBeaconDetected(beaconID: beaconID)
    }
    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillProgress(){}
    // func somethingRequestDidProgress(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}

}
