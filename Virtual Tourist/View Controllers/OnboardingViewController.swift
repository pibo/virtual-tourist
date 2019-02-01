//
//  OnboardingViewController.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 31/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - Properties
    
    let animationDuration: TimeInterval = 0.3
    let backgroundTransparency: CGFloat = 0.6
    
    // MARK: - Outlets

    @IBOutlet var wrapper: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet var tourist: UIImageView!
    
    // MARK: Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    // MARK: - Helper Methods
    
    func setupView() {
        wrapper.layer.cornerRadius = 16
        view.backgroundColor = UIColor.black.withAlphaComponent(backgroundTransparency)
        button.tintColor = UIColor(named: "Primary Yellow")
    }
    
    func animateView() {
        tourist.alpha = 0
        wrapper.alpha = 0
        tourist.frame.origin.y = tourist.frame.origin.y + 32
        wrapper.frame.origin.y = wrapper.frame.origin.y + 32
        
        UIView.animate(withDuration: animationDuration) {
            self.tourist.alpha = 1
            self.wrapper.alpha = 1
            self.tourist.frame.origin.y = self.tourist.frame.origin.y - 32
            self.wrapper.frame.origin.y = self.wrapper.frame.origin.y - 32
        }
    }
    
    // MARK: - Actions
    
    @IBAction func ok(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
