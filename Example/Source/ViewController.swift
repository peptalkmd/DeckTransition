//
//  ViewController.swift
//  DeckTransition
//
//  Created by Harshil Shah on 10/15/2016.
//  Copyright (c) 2016 Harshil Shah. All rights reserved.
//

import UIKit
import DeckTransition

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = """
        This is the presenting view controller.\n
        Tap anywhere to show the modal.
        """
        
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewWasTapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewWasTapped() {
        let modal = ModalViewController()
        let transitionDelegate = DeckTransitioningDelegate()
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        transitionDelegate.isSwipableSubViews = true
        transitionDelegate.isSwipableScrollView = true
        transitionDelegate.transitionMode = .defaultTransition
        transitionDelegate.presentedVCTopIndicatorBarColor = UIColor.gray.withAlphaComponent(0.6)
        let constants = DeckConstants()
        constants.insetForPresentedView = 200
        transitionDelegate.deckConstants = constants
        present(modal, animated: true, completion: nil)
    }
}

