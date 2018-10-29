//
//  BookViewModel.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/20/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation

class BookListViewModel {
    
    private(set) var bookViewModels = [BookViewModel]()
    
    var completion: () -> Void
    
    init(completion : @escaping () -> Void) {
        self.completion = completion
        fetchData()
    }
    
    //Note: Mutating a value inside struct for async call will not work, but might synchronoulsy ( because self exits before the closure is even dispatched .)
    func fetchData() {
        Service.makeaBackendCall { (model) in
            if case .success(let data) = model {
                self.bookViewModels = data.books.map(BookViewModel.init)
                self.completion()
            }
        }
    }
    
}

struct DataViewModel {
    var model:Model
    
    init(model: Model) {
        self.model = model
    }
}

class BookViewModel {
    var book: Book
    
    init(book: Book) {
        self.book = book
    }
}

extension BookViewModel {
    
    var name: String {
        return "\(book.title)"
    }
}
