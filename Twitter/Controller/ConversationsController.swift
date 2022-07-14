//
//  MainTabViewController.swift
//  Twitter
//
//  Created by Wagner Barboza Goulart on 27/06/22.
//

import UIKit

class ConversationsController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
    
    // MARK: - Helpers
    
}
