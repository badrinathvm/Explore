//
//  ViewController.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/15/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    private var dataSource:TableViewDataSource<Product>?
    
    fileprivate let cellId = "productCell"
    
    lazy var tableView: UITableView = { [unowned self] in
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    lazy var segmentView:UIView =  { [unowned self] in
        var view = SegmentView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView:UIView = { [unowned self] in
        var view = ContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate func setupContainerView() {
        self.view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(segmentView)
        
        NSLayoutConstraint.activate([
             segmentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             segmentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             segmentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             segmentView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //setupContainerView()
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
           tableView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 10),
           tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        products.append( Product(name: "Button1"))
        products.append( Product(name: "Button3"))
        
        tableView.tableFooterView = UIView()
        
        self.dataSource = .make(for: products)

        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
}

extension ViewController: ContainerViewDelegate {
    func didRemoveContainerView(index: Int) {
        if index%2 == 0 {
            containerView.removeFromSuperview()
        }else {
            setupContainerView()
        }
    }
}

//Creating a new reusable tableview data source
extension TableViewDataSource where Model == Product {

    static func make(for products:  [Product] , reuseIdentifier: String = "productCell" ) -> TableViewDataSource{

        let dataSource = TableViewDataSource(models: products, reuseIdentifier: reuseIdentifier ) { (product, cell) in
            cell.textLabel?.text = product.name
        }

        return dataSource
    }
}



