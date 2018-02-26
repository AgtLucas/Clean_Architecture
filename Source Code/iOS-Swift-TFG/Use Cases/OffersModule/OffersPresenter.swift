//
//  OffersPresenter.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Presenter
protocol OffersEventHandler:class
{
    var viewModel : OffersViewModel { get }
    
    func handleViewWillAppear()
    func handleViewWillDisappear()
}

// MARK: - Protocol to be defined at Presenter
protocol OffersResponseHandler: class
{
    func offersRequestDidFinish(offersDTO: OffersDTO)
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class OffersPresenter: OffersEventHandler, OffersResponseHandler {
    
    //MARK: relationships
    weak var viewController : OffersViewUpdatesHandler?
    var interactor : OffersRequestHandler!
    var wireframe : OffersNavigationHandler!

    var viewModel = OffersViewModel()
    
    //MARK: EventsHandler Protocol
    func handleViewWillAppear() {
        //TODO:
        self.interactor.requestOffers(query: "iOS", province: "barcelona")
    }
    
    func handleViewWillDisappear() {
        //TODO:
    }
    
    func offersRequestDidFinish(offersDTO: OffersDTO) {
        self.viewController?.updateOffersTable(offersDTO: offersDTO)
    }
    
    //MARK: ResponseHandler Protocol
    
    // func somethingRequestWillStart(){}
    // func somethingRequestDidStart(){}
    // func somethingRequestWillProgress(){}
    // func somethingRequestDidProgress(){}
    // func somethingRequestWillFinish(){}
    // func somethingRequestDidFinish(){}

}
