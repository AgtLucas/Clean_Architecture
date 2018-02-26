//
//  OffersDTO.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import Foundation
import ObjectMapper

class OffersDTO: Mappable {
    var totalResults: String?
    var offers: Array<OfferDTO>
    
    required init?(map: Map) {
        self.offers = Array<OfferDTO>()
    }
    
    func mapping(map: Map) {
        totalResults <- map["totalResults"]
        offers <- map["offers"]
    }
}
