//
//  CustomView.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 10/19/20.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var backColor: UIColor  {
        set {
            self.backgroundColor = newValue
        }
        get{
            return self.backgroundColor ?? .white
        }
    }
    

}
