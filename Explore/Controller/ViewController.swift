//
//  ViewController.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/15/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    private var dataSource:GenericTableviewDataSource<BookViewModel>?
    private var viewModel: BookViewModel?
    
    var bookListViewModel:BookListViewModel?
    
    lazy var listviewController:BookListViewController = {
        let viewController = BookListViewController()
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    fileprivate let cellId = "bookCell"
    
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
        add(listviewController)
        NSLayoutConstraint.activate([
            listviewController.view.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 5),
            listviewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listviewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listviewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    

    
    var books: [Book] = []
    
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
        
        tableView.tableFooterView = UIView()
        
        bookListViewModel = BookListViewModel(completion: {
            
            guard let bookViewModel = self.bookListViewModel?.bookViewModels else { return }
            
            //self.dataSource = .make(for: bookViewModel)
            self.dataSource = GenericTableviewDataSource.make(for: bookViewModel, reuseIdentifier: self.cellId)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        })
    }
}

extension ViewController: ContainerViewDelegate {
    func didRemoveContainerView(index: Int) {
        if index%2 == 0 {
            listviewController.remove()
        }else {
            setupContainerView()
        }
    }
}

//Creating a new reusable tableview data source
extension TableViewDataSource where Model == BookViewModel {

    static func make(for books:  [Model] , reuseIdentifier: String = "bookCell" ) -> TableViewDataSource{

        let dataSource = TableViewDataSource(models: books, reuseIdentifier: reuseIdentifier ) { (book, cell) in
            cell.textLabel?.text = book.name
        }

        return dataSource
    }
}

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

extension GenericTableviewDataSource where Model == BookViewModel {
    
    static func make(for books: [Model], reuseIdentifier: String ) -> GenericTableviewDataSource {
        let dataSource = GenericTableviewDataSource(models: books, reuseIdentifier: reuseIdentifier) { (model, cell) in
            //cell.textLabel?.text = model.name
            
            let cellConfig = TableCellConfigurator<BookViewModel>(titleKeyPath: \.name)
            cellConfig.configure(cell: cell, for: model)
        }
        
        return dataSource
    }
}


struct TableCellConfigurator<Model> {
    
    let titleKeyPath:KeyPath<Model, String>
    
    func configure(cell: UITableViewCell, for model: Model) {
        cell.textLabel?.text = model[keyPath: titleKeyPath]
    }
    
}

