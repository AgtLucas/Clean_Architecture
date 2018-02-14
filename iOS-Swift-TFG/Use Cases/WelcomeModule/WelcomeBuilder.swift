//
//  WelcomeBuilder.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 10/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit


class WelcomeBuilder
{
    static func build() -> UIViewController {
        let viewController = WelcomeViewController(nibName:String.init(describing: WelcomeViewController.self), bundle: nil)
        let presenter = WelcomePresenter()
        let interactor = WelcomeInteractor()
        let wireframe = WelcomeWireframe()
        
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
