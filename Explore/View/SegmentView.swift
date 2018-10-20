//
//  SegmentView.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/15/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

protocol ContainerViewDelegate:class {
    func didRemoveContainerView(index: Int)
}

class SegmentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    let segmentControlData = ["Books1","Books2","Books3","Books4", "Books5","Books6", "Books7", "Books8"]
    
    weak var delegate:ContainerViewDelegate?
    
    fileprivate let segmentCell = "SegmentCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    lazy var horizontalBar:UIView = { [unowned self] in
        var bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        //bar.frame = CGRect(x: 0, y: 36, width: 70, height: 4)
        bar.backgroundColor = UIColor(red: 0.0314, green: 0.4784, blue: 0.4353, alpha: 1.0)
        return bar
    }()

    
    lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TextCell.self, forCellWithReuseIdentifier: segmentCell)
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var horizontalBarLeadingConstraint:NSLayoutConstraint?
    
    func setup() {
        addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        addSubview(horizontalBar)
            
        //Set the frame the bottom of the
        horizontalBarLeadingConstraint = horizontalBar.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        NSLayoutConstraint.activate([
            horizontalBarLeadingConstraint!,
            horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8),
            horizontalBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentControlData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: segmentCell, for: indexPath) as! TextCell
        cell.segmentLabel.text = segmentControlData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Get the new x value to shift
        print("Index Item is \(indexPath.item)")
        let x = CGFloat(indexPath.item) * frame.width / 8
        print("x valus is \(x)")
        self.indexPath = indexPath
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        self.previouslySet = cell.frame.origin.x
        horizontalBarLeadingConstraint?.constant = cell.frame.origin.x
        
        //self.indexPath = indexPath
        //self.setNeedsLayout()
        
        //if indexPath.row == 2 {
            delegate?.didRemoveContainerView(index: indexPath.row)
        //}
    }
    
    var indexPath: IndexPath?
    var previouslySet:CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let indexPath = indexPath,  let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        let cellFrame = cell.convert(cell.bounds, to: horizontalBar.superview!)
        
        self.horizontalBar.frame = { () -> CGRect in
            var frame = self.horizontalBar.frame
            //frame.origin.x = (cellFrame.midX - horizontalBar.frame.width/2.0)
           UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseOut, animations: {
                frame.origin.x = cellFrame.origin.x
                frame.origin.y = cellFrame.maxY
                self.layoutIfNeeded()
            })
            return frame
        }()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Without AutoLayout
       //setNeedsLayout()
        
       //with Autolayout to redraw the view immediately.
       layoutIfNeeded()
        
        guard let indexPath = indexPath,let cell = collectionView.cellForItem(at: indexPath) else {
            //print("Going out")
            return
        }
        
        let cellFrame = cell.convert(cell.bounds, to: horizontalBar.superview!)
        horizontalBarLeadingConstraint?.constant = cellFrame.origin.x
        
        UIView.animate(withDuration: 0.9) {
            self.layoutIfNeeded()
        }
    }
    
}
