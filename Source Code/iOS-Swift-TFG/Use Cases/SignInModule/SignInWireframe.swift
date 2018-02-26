//
//  SignInWireframe.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol SignInNavigationHandler:class
{
    // Include methods to present or dismiss
    func presentLoginWithLinkedInModule()
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation calls
class SignInWireframe: SignInNavigationHandler
{
    weak var viewController : SignInViewController?
    
    func presentLoginWithLinkedInModule() {
        self.viewController?.present(LoginWithLinkedInBuilder.build(), animated: true, completion: nil)
    }
}
