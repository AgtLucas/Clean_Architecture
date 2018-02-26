//
//  OffersInteractor.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol OffersRequestHandler:class
{
    func requestOffers(query: String, province: String)
    // func requestSomething()
    // func requestUser(id:String)
}


// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class OffersInteractor: OffersRequestHandler
{
    //MARK: Relationships
    weak var presenter : OffersResponseHandler?
    
    var repository = NetworkRepository()
    
    //MARK: RequestHandler Protocol
    func requestOffers(query: String, province: String) {
        self.repository.fetchOffers(query: query, province: province, handleOffersResponseDTO: { (offersResponseDTO) in
            switch(offersResponseDTO){
            case let .success(offersDTO: offersDTO):
                //Create the Entity from DTO adding business logic.
                self.presenter?.offersRequestDidFinish(offersDTO: offersDTO)
                
            case .fail(offersFailDTO: _):
                break
            }
        })
        
    }
}

