//
//  WelcomeWireframe.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 10/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol WelcomeNavigationHandler:class
{
    // Include methods to present or dismiss
    func presentOffersModule()
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation calls
class WelcomeWireframe: WelcomeNavigationHandler
{
    weak var viewController : WelcomeViewController?
    
    func presentOffersModule() {
         self.viewController?.present(OffersBuilder.build(), animated: true, completion: nil)
    }
}
