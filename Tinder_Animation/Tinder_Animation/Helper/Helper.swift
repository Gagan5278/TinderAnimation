//
//  Helper.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 10/19/20.
//

import Foundation
import UIKit
class Helper {
    
    //MARK:- Convert degree into radins
    class func getRadians(from degree: CGFloat) -> CGFloat {
        return((.pi * degree) / degree)
    }
}
