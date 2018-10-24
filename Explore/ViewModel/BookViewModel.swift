//
//  BookViewModel.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/20/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation

struct BookViewModel {
    private let model: Book
    
    init(model: Book) {
        self.model = model
    }
}

extension BookViewModel {
    
    var name: String {
        return "\(model.name)"
    }
}
