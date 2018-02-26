//
//  WelcomeInteractor.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 10/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import CoreLocation

// MARK: - Protocol to be defined at Interactor
protocol WelcomeRequestHandler:class
{
    // func requestSomething()
    // func requestUser(id:String)
    
    func requestProfile()
    func setupBeacons()
}

protocol BeaconRepositoryHandler:class
{
    func handleBeaconRange(beaconID: String)
}


// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class WelcomeInteractor: WelcomeRequestHandler, BeaconRepositoryHandler
{
    //MARK: Relationships
    weak var presenter : WelcomeResponseHandler?
    
    var repository = NetworkRepository()
    var beaconRepository: BeaconsCoordinator?
    
    //MARK: RequestHandler Protocol
    //func requestSomething(){}
    
    func requestProfile(){
        
        if let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken") {

            self.repository.fetchProfile(accessToken: accessToken as! String, entityReceivedClosure: { (profileResponseDTO) in
                switch(profileResponseDTO) {
                case let .success(profileDTO: ProfileDTO):
                    self.presenter?.profileRequestDidFinish(profileDTO: ProfileDTO)
                    break
                case .fail(profileFailDTO: _):
                    
                    break

                }
            })
        }
    }
    
    func setupBeacons(){
        let uuid3:UUID = UUID.init(uuidString: "8492E75F-4FD6-469D-B132-043FE94921D8")!
        //let uuid:UUID = UUID.init(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
        //let uuid2:NSUUID = NSUUID.init(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        //let beaconRegion1:CLBeaconRegion = CLBeaconRegion.init(proximityUUID: uuid2 as UUID, identifier: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0-1-1")
        //let beaconRegion2:CLBeaconRegion = CLBeaconRegion.init(proximityUUID: uuid as UUID, identifier: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5-1-1")
        let beaconRegion3:CLBeaconRegion = CLBeaconRegion.init(proximityUUID: uuid3 as UUID, identifier: "8492E75F-4FD6-469D-B132-043FE94921D8-1-1")
        
        let array = [/*beaconRegion1, beaconRegion2,*/ beaconRegion3]
        beaconRepository = BeaconsCoordinator.init(beaconRegions: array, startMonitoring:true)
        beaconRepository?.interactor = self
    }
    
    func handleBeaconRange(beaconID: String) {
        self.presenter?.beaconRepositoryDidRangeBeacon(beaconID: beaconID)
    }

}

