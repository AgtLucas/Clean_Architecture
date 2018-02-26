//
//  NetworkDataSource.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 5/6/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import ObjectMapper

protocol AccessTokenTransactions {
    func fetchAccesTokenSending(authorizationCode: String, handleAccessTokenResponseDTO: @escaping (AccessTokenResponseDTO) -> () )
}

protocol ProfileRepository {
    //FIXME: - entityReceivedClosure
    func fetchProfile(accessToken: String, entityReceivedClosure: @escaping (ProfileResponseDTO) -> () )
}

protocol OffersRepository {
    func fetchOffers(query: String, province:String, handleOffersResponseDTO: @escaping (OffersResponseDTO) -> () )
}

class NetworkRepository: AccessTokenTransactions, ProfileRepository, OffersRepository {

    
    func fetchAccesTokenSending(authorizationCode: String, handleAccessTokenResponseDTO: @escaping (AccessTokenResponseDTO) -> () ) {
        
        let moyaProvider = MoyaProvider<MultiTarget>()
        
        moyaProvider.request(MultiTarget(LoginRequestDTO(authorizationCode: authorizationCode)), completion: {result in
            switch(result){
            case let .success(response):
                let jsonString = NSString(data: response.data, encoding: String.Encoding.utf8.rawValue)
                let accessTokenDTO = Mapper<AccessTokenDTO>().map(JSONString: jsonString! as String)
                
                handleAccessTokenResponseDTO(AccessTokenResponseDTO.success(accessTokenDTO: accessTokenDTO!))
                
            case let .failure(error):
                print(error)
            }
            
        })
    }
    
    func fetchProfile(accessToken: String, entityReceivedClosure: @escaping (ProfileResponseDTO) -> ()) {
        let authPlugin = AccessTokenPlugin(token: accessToken)
        let moyaProvider = MoyaProvider<MultiTarget>(plugins: [authPlugin])
        
        moyaProvider.request(MultiTarget(ProfileRequestDTO()), completion: {result in
            switch(result){
            case let .success(response):
                /*
                 SWIFTYJSON
                 let json = JSON(data: response.data)
                 */
                let jsonString = NSString(data: response.data, encoding: String.Encoding.utf8.rawValue)
                let profileDTO = Mapper<ProfileDTO>().map(JSONString: jsonString! as String)

                entityReceivedClosure(ProfileResponseDTO.success(profileDTO: profileDTO!))
                
            case let .failure(error):
                print(error)
            }
            
        })

    }
    
    func fetchOffers(query: String, province: String, handleOffersResponseDTO: @escaping (OffersResponseDTO) -> ()) {

        let credentialPlugin = CredentialsPlugin { _ -> URLCredential? in
            return URLCredential(user: "b2226970849844628b7dadae1aab7645", password: "fVebu05OxjZ3k8b5MKLnPsJaZoOqZFjMr5jw2/KC+HID945SOf", persistence: .none)
        }
        let moyaProvider = MoyaProvider<MultiTarget>(plugins: [credentialPlugin])
        
        moyaProvider.request(MultiTarget(OffersRequestDTO(query: query, province: province)), completion: {result in
            switch(result){
            case let .success(response):
                let jsonString = NSString(data: response.data, encoding: String.Encoding.utf8.rawValue)
                
                let offersDTO = Mapper<OffersDTO>().map(JSONString: jsonString! as String)
                handleOffersResponseDTO(OffersResponseDTO.success(offersDTO: offersDTO!))
                
            case let .failure(error):
                print(error)
            }
            
        })
    }
    
}
