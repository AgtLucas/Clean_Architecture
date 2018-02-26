//
//  AccessTokenResponseEntity.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 5/6/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit

enum AccessTokenResponseEntity {
    case success(accessTokenEntity: AccessTokenEntity)
    case fail(accesTokenFailEntity: AccessTokenFailEntity)
}


