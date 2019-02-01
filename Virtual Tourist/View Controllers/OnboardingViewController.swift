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
    
    // MARK: - Outlets

    @IBOutlet var wrapper: UIView!
    @IBOutlet var button: UIButton!
    
    // MARK: Life Cycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    // MARK: - Helper Methods
    
    func setupView() {
        wrapper.layer.cornerRadius = 16
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.tintColor = UIColor(named: "Primary Yellow")
    }
    
    func animateView() {
        
    }
    
    // MARK: - Actions
    
    @IBAction func ok(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
