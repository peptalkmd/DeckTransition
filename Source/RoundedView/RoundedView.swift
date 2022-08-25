//
//  RoundedView.swift
//  DeckTransition
//
//  Created by Harshil Shah on 05/08/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import UIKit

final class RoundedView: UIView {
    
    // MARK: - Public variables
    public var cornerRadius : CGFloat = 0 {
        didSet {
            leftCorner.cornerRadius = cornerRadius
            rightCorner.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Private variables
    
    private let leftCorner = CornerView()
    private let rightCorner = CornerView()
    private var barView : UIView? = nil
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        leftCorner.corner = .topLeft
        rightCorner.corner = .topRight
        
        leftCorner.cornerRadius = cornerRadius
        rightCorner.cornerRadius = cornerRadius
        
        leftCorner.translatesAutoresizingMaskIntoConstraints = false
        rightCorner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftCorner)
        addSubview(rightCorner)
    }
    
    public func addTopBarIndicator(with color: UIColor){
        let barView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 5))
        barView.backgroundColor = color
        self.addSubview(barView)
        self.bringSubviewToFront(barView)
        self.barView = barView
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    // MARK: - UIView methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftCorner.frame = bounds
        rightCorner.frame = bounds
        if let view = barView {
            view.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2 + 2)
            view.layer.cornerRadius = view.frame.size.height / 2
            view.clipsToBounds = true
        }
    }
    
}
