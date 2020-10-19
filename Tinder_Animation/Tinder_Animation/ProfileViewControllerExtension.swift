//
//  ProfileViewControllerExtension.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 10/19/20.
//

import UIKit

extension ProfileViewController {
    func animateToggleButton(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            if self.circularView.transform == CGAffineTransform.identity {
                self.circularView.transform = CGAffineTransform(scaleX: 20, y: 20)
                self.animationHolderParentView.transform = CGAffineTransform(translationX: 0, y: -64)
                sender.transform = CGAffineTransform(rotationAngle: Helper.getRadians(from: 180.0))
                UIView.animate(withDuration: 0.3) {
                    self.transformButtonsAlpha()
                }
            }
            else {
                UIView.animate(withDuration: 0.1) {
                    self.transformButtonsAlpha()
                    
                } completion: { (_) in
                    UIView.animate(withDuration: 0.7) {
                        self.circularView.transform = .identity
                        self.animationHolderParentView.transform = .identity
                        sender.transform = .identity
                    }
                }
            }
        }
    }
    
    //MARK:- Share button's alpha reset
    fileprivate func transformButtonsAlpha() {
        btnFB.alpha = btnFB.alpha == 0 ? 1 : 0
        btnTwitter.alpha = btnTwitter.alpha == 0 ? 1 : 0
        btnInstagram.alpha = btnInstagram.alpha == 0 ? 1 : 0
        btnWhatsApp.alpha = btnWhatsApp.alpha == 0 ? 1 : 0
    }

}
