//
//  BookListViewController.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/23/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class BookListViewController: UITableViewController {
    
    override func viewDidLoad() {
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func loadItems() {
        let loadingViewController = LoadingViewController()
        add(loadingViewController)
    }
}
