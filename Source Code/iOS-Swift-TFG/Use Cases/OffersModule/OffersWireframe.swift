//
//  OffersWireframe.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol OffersNavigationHandler:class
{
    // Include methods to present or dismiss
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation calls
class OffersWireframe: OffersNavigationHandler
{
    weak var viewController : OffersViewController?
}
