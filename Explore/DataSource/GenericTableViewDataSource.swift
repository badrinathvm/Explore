//
//  GenericTableViewDataSource.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/26/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class GenericTableviewDataSource<Model>: NSObject , UITableViewDataSource {
    
    typealias CellConfigurator = (Model, UITableViewCell) -> Void
    
    var models:[Model]
    var cellConfig:CellConfigurator
    var reuseIdentifier: String
    
    init(models: [Model], reuseIdentifier: String , cellConfig: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfig = cellConfig
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cellConfig(models[indexPath.row], cell)
        
        return cell
    }
}
