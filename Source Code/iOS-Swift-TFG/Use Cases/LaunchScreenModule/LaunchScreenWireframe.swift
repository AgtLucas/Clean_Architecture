//
//  LaunchScreenWireframe.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol LaunchScreenNavigationHandler:class
{
    // Include methods to present or dismiss
    func presentSignInModule()
    func presentWelcomeModule()
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation calls
class LaunchScreenWireframe: LaunchScreenNavigationHandler
{
    weak var viewController : LaunchScreenViewController?
    
    
    func presentSignInModule() {
        self.viewController?.present(SignInBuilder.build(), animated: true, completion: nil)
    }
    
    func presentWelcomeModule(){
        self.viewController?.present(WelcomeBuilder.build(), animated: true, completion: nil)
    }
}
