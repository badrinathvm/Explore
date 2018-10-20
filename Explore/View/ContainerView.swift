//
//  ContainerView.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/16/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit


class ContainerView: UIView  {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .red
    }
}
