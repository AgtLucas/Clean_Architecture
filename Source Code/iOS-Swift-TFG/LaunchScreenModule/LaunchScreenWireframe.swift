//
//  LaunchScreenWireframe.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 19/3/17.
//  Copyright © 2017 Jonattan Nieto Sánchez. All rights reserved.
//

import UIKit

class LaunchScreenWireframe {
    
    var launchScreenPresenter : LaunchScreenPresenter!
    var signInWireframe : SignInWireframe?

    init() {
        self.launchScreenPresenter = LaunchScreenPresenter.init(launchScreenWireframe:self)
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        window.rootViewController = UINavigationController.init(rootViewController: self.launchScreenPresenter.launchScreenViewController)
        
        window.makeKeyAndVisible()
    }
    
    func presentSignInModule() -> () {
        self.signInWireframe = SignInWireframe.init()
        self.signInWireframe?.presentSignInViewControllerFromViewController(viewController: self.launchScreenPresenter.launchScreenViewController)
        
        self.launchScreenPresenter.launchScreenViewController.show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
        
    }
    
}
