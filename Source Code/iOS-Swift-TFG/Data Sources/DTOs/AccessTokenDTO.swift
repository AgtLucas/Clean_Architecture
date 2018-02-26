//
//  AccessTokenResponseDTO.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 5/6/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import Foundation
import ObjectMapper

class AccessTokenDTO: Mappable {
    var accessToken: String?
    var expiresIn: Int?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
    }
}
