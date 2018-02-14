//
//  ProfileResponseDTO.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 12/06/2017.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit

enum  ProfileResponseDTO {
    case success(profileDTO: ProfileDTO)
    case fail(profileFailDTO: ProfileFailDTO)
}
