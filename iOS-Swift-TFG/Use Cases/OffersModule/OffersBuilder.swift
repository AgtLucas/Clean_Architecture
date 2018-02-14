//
//  OffersBuilder.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit


class OffersBuilder
{
    static func build() -> UIViewController {
        let viewController = OffersViewController(nibName:String.init(describing: OffersViewController.self), bundle: nil)
        let presenter = OffersPresenter()
        let interactor = OffersInteractor()
        let wireframe = OffersWireframe()
        
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
