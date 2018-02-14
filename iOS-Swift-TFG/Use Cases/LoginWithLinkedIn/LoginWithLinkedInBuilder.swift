//
//  LoginWithLinkedInBuilder.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 3/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit


class LoginWithLinkedInBuilder
{
    static func build() -> UIViewController {
        let viewController = LoginWithLinkedInViewController(nibName:String.init(describing: LoginWithLinkedInViewController.self), bundle: nil)
        let presenter = LoginWithLinkedInPresenter()
        let interactor = LoginWithLinkedInInteractor()
        let wireframe = LoginWithLinkedInWireframe()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController
        
        _ = viewController.view //force loading the view to load the outlets
        return viewController
    }
}
