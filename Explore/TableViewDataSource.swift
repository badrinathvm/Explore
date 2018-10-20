//
//  TableViewDataSource.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/20/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Model> : NSObject, UITableViewDataSource {
    
    typealias CellConfig = (Model, UITableViewCell) -> Void
    
    var models:  [Model]
    private let reuseIdentifier:String
    private let cellConfig:CellConfig
    
    init(models: [Model],reuseIdentifier: String, cellConfig : @escaping CellConfig) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfig = cellConfig
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let model = models[indexPath.row]
        
        cellConfig(model,cell)
        
        return cell
    }
}
