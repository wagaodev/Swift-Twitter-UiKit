//
//  MainTabViewController.swift
//  Twitter
//
//  Created by Wagner Barboza Goulart on 27/06/22.
//

import UIKit

class FeedController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        let iv = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        iv.contentMode = .scaleAspectFit
        navigationItem.titleView = iv
    }
    
    // MARK: - Helpers
    
}
