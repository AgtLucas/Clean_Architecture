//
//  LoginWithLinkedInWireframe.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 3/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol LoginWithLinkedInNavigationHandler:class
{
    // Include methods to present or dismiss
    func presentWelcomeModule()
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation calls
class LoginWithLinkedInWireframe: LoginWithLinkedInNavigationHandler
{
    weak var viewController : LoginWithLinkedInViewController?
    
    func presentWelcomeModule() {
        self.viewController?.present(WelcomeBuilder.build(), animated: true, completion: nil)
    }
    
    
    
}
