//
//  LoginWithLinkedInViewController.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 3/6/17.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at ViewController
protocol LoginWithLinkedInViewUpdatesHandler:class
{
    func updateWebView(urlRequest: URLRequest)
    //That part should be implemented with RxSwift.
    //func updateSomeView()
}

// MARK: - ViewController Class must implement ViewModelHandler Protocol to handle ViewModel from Presenter
class LoginWithLinkedInViewController: UIViewController, LoginWithLinkedInViewUpdatesHandler
{
    //MARK: relationships
    var presenter: LoginWithLinkedInEventHandler!
    
    var viewModel : LoginWithLinkedInViewModel {
        get {
            return presenter.viewModel
        }
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = (self.presenter as! UIWebViewDelegate)
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
    
    //MARK: ViewUpdatesHandler Protocol
    func updateWebView(urlRequest: URLRequest){
        self.webView.loadRequest(urlRequest)
    }
}
