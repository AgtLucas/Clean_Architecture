//
//  ProfileDTO.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 12/06/2017.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileDTO: Mappable {
    var firstName: String?
    var lastName: String?
    var pictureURL: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        pictureURL <- map["pictureUrl"]
    }
}
