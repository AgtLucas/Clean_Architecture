//
//  SignInBuilder.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit


class SignInBuilder
{
    static func build() -> UIViewController {
        let viewController = SignInViewController(nibName:String.init(describing: SignInViewController.self), bundle: nil)
        let presenter = SignInPresenter()
        let interactor = SignInInteractor()
        let wireframe = SignInWireframe()
        
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
