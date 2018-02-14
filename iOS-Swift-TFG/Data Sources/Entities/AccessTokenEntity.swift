//
//  AccessTokenEntity.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 5/6/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit





class AccessTokenEntity: NSObject {
    var accessToken: String
    var expiresIn: Int
    var obtainingDate: String
    
    
    init(accessTokenDTO: AccessTokenDTO) {
        self.accessToken = accessTokenDTO.accessToken!
        self.expiresIn = accessTokenDTO.expiresIn!
        self.obtainingDate = "\(NSDate())"
    }
}
