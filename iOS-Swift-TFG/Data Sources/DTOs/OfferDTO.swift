//
//  OfferDTO.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import Foundation
import ObjectMapper

class OfferDTO: Mappable {
    var city: String?
    var link: String?
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        city <- map["city"]
        link <- map["link"]
        title <- map["title"]
        
    }
}
