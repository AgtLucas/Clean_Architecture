//
//  WelcomeViewController.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 10/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit
import SDWebImage

// MARK: - Protocol to be defined at ViewController
protocol WelcomeViewUpdatesHandler:class
{
    //That part should be implemented with RxSwift.
    //func updateSomeView()
    func updateProfileView(profileName: String, profileURLImage: String)
    func showBeaconDetected(beaconID: String)
}

// MARK: - ViewController Class must implement ViewModelHandler Protocol to handle ViewModel from Presenter
class WelcomeViewController: UIViewController, WelcomeViewUpdatesHandler
{
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    //MARK: relationships
    var presenter: WelcomeEventHandler!
    
    var viewModel : WelcomeViewModel {
        return presenter.viewModel
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }
    
    func configureBindings() {
        //Add the ViewModel bindings here ...
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.handleViewWillDisappear()
    }
    
    func updateProfileView(profileName: String, profileURLImage: String) {
        self.userNameLabel.text = profileName
        self.userProfileImage.sd_setImage(with: URL(string: profileURLImage), placeholderImage: UIImage(named: "avatar-placeholder"))
    }
    
    func showBeaconDetected(beaconID: String) {
        //self.presentOffer()
    }
    
    // MARK: IBActions
    
    @IBAction func searchOffersPressed(_ sender: UIButton) {
        presenter.handleSearchOffersPressed()
    }
    
}
