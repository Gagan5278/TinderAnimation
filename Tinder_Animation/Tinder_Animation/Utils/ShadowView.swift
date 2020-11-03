//
//  ShadowView.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 11/3/20.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createAndApplyShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createAndApplyShadow()
    }
    
    //MARK:- Create And Apply Shadow
    fileprivate func createAndApplyShadow(){
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowRadius = 0.5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
    }
}
