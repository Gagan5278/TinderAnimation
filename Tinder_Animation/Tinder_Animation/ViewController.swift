//
//  ViewController.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 10/18/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var wlcmBackTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetAlphaToZero()
        self.animateImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    fileprivate func resetAlphaToZero() {
        self.bgImage.alpha = 0.0
        self.wlcmBackTitle.alpha = 0.0
        self.titleLabel.alpha = 0.0
        self.continueButton.alpha = 0.0
    }
    
    fileprivate func animateImage()
    {
        UIView.animate(withDuration: 1.0) {
            self.bgImage.alpha = 1.0
        } completion: { (_) in
            self.animateTitle()
        }
    }
    
    func animateTitle() {
        UIView.animate(withDuration: 1.0) {
            self.titleLabel.alpha = 1.0
        } completion: { (_) in
            self.animateWlcmLabel()
        }
    }
    
    func animateWlcmLabel() {
        UIView.animate(withDuration: 1.0) {
            self.wlcmBackTitle.alpha = 1.0
        } completion: { (_) in
            self.animateContinueButton()
        }
    }
    
    func animateContinueButton() {
        UIView.animate(withDuration: 1.0) {
            self.continueButton.alpha = 1.0
        } completion: { (_) in
            
        }
    }
}

