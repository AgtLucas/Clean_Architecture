//
//  OffersViewController.swift
//  iOS-Swift-TFG
//
//  Created by Jonattan Nieto Sánchez on 15/06/2017.
//  Copyright (c) 2017 Jonattan Nieto Sánchez. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at ViewController
protocol OffersViewUpdatesHandler:class
{
    //That part should be implemented with RxSwift.
    //func updateSomeView()
    func updateOffersTable(offersDTO: OffersDTO)
}

// MARK: - ViewController Class must implement ViewModelHandler Protocol to handle ViewModel from Presenter
class OffersViewController: UIViewController, OffersViewUpdatesHandler, UITableViewDelegate, UITableViewDataSource
{
    var offersArray: Array<OfferDTO>?
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: relationships
    var presenter: OffersEventHandler!
    
    var viewModel : OffersViewModel {
        return presenter.viewModel
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func updateOffersTable(offersDTO: OffersDTO) {
        self.offersArray = Array(offersDTO.offers)
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource , Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = offersArray {
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "UITableViewCell")
        if let array = offersArray {
            cell.textLabel?.text = array[indexPath.row].title
        } else {
             cell.textLabel?.text = "No results"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let array = offersArray {
            let link = array[indexPath.row].link
            if let url = link {
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            }
        }
    }
}
