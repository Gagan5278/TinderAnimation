//
//  ProfileViewController.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 10/19/20.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var animationHolderParentView: UIView!
    @IBOutlet weak var circularView: CustomView!
    @IBOutlet weak var btnFB: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var btnWhatsApp: UIButton!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var foodImageView: UIImageView!
    //create a divisor which givez rotation of 35 degree
    var devisor : CGFloat!
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.devisor = (self.view.frame.width/2) / 0.30
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.animationHolderParentView.removeFromSuperview()
    }
    //MARK:- Toogle Button Action
    @IBAction func animationButtonPressed(_ sender: UIButton) {
        animateToggleButton(sender)
    }
    
    //MARK:- Pan Gesture
    fileprivate func recenterCard(_ card: UIView) {
        let imageIndex = Array(0...6).randomElement()
        let imageName = "f\(imageIndex!)"
        UIView.animate(withDuration: 0.5) {
            card.center = CGPoint(x: self.view.center.x , y: self.view.center.y)
            self.foodImageView.image = UIImage(named: imageName)
            self.thumbImageView.alpha = 0.0
            card.transform = .identity
        }
    }
    
    @IBAction func cardPanGestureAction(_ sender: UIPanGestureRecognizer) {
        if let card = sender.view {
            let newPoint = sender.translation(in: card)
            //set card center
            card.center = CGPoint(x: self.view.center.x + newPoint.x, y: self.view.center.y + newPoint.y)
            //Get Direction
            let respectedPoint = (card.center.x - self.view.center.x)
            //Saling
            let scaled = ( 1 - abs(respectedPoint/self.devisor))
            //Rotate
            card.transform = CGAffineTransform(rotationAngle: respectedPoint/self.devisor).scaledBy(x: scaled, y: scaled)
            //Set image
            if respectedPoint > 0 {
                self.thumbImageView.image = #imageLiteral(resourceName: "thumbs")
                self.thumbImageView.tintColor = .green
            }
            else {
                self.thumbImageView.image = #imageLiteral(resourceName: "thumbsdown")
                self.thumbImageView.tintColor = .red
            }
            //Set image alpha
            let imageAlpha = abs(respectedPoint)/self.view.center.x
            self.thumbImageView.alpha = imageAlpha
            //Reset if geesture ended

            if sender.state == .ended {
                
                if card.center.x < 75.0 {
                    UIView.animate(withDuration: 0.3) {
                        card.center = CGPoint(x: self.view.center.x - self.view.frame.width , y: self.view.center.y + 75)
                    }completion: { (_) in
                        card.center = CGPoint(x: self.view.center.x + self.view.frame.width , y: self.view.center.y + 75)
                        self.recenterCard(card)
                    }
                    return
                }
                else if card.center.x > (self.view.frame.width - 75) {
                    UIView.animate(withDuration: 0.3) {
                        card.center = CGPoint(x: self.view.center.x + self.view.frame.width , y: self.view.center.y + 75)
                    } completion: { (_) in
                        card.center = CGPoint(x: self.view.center.x - self.view.frame.width , y: self.view.center.y + 75)
                        self.recenterCard(card)
                    }
                    return
                }
                UIView.animate(withDuration: 0.5) {
                    card.center = CGPoint(x: self.view.center.x , y: self.view.center.y)
                    self.thumbImageView.alpha = 0.0
                    card.transform = .identity
                }
            }
        }
    }
    
}
