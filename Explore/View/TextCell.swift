//
//  TextCell.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/15/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class TextCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    lazy var segmentLabel: UILabel = { [unowned self] in
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.0314, green: 0.4784, blue: 0.4353, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        //label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        addSubview(segmentLabel)
        
        NSLayoutConstraint.activate([
            segmentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            segmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            segmentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
