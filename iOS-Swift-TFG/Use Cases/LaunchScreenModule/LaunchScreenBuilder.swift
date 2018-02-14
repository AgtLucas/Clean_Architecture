//
//  LaunchScreenBuilder.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 11/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit


class LaunchScreenBuilder
{
    static func build() -> UIViewController {
        let viewController = LaunchScreenViewController(nibName:String.init(describing: LaunchScreenViewController.self), bundle: nil)
        let presenter = LaunchScreenPresenter()
        let interactor = LaunchScreenInteractor()
        let wireframe = LaunchScreenWireframe()
        
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
