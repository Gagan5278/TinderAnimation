//
//  CustomGridViewController.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 11/1/20.
//

import UIKit

class CustomGridViewController: UIViewController {
    fileprivate let width: CGFloat = 30
    var viewHolderDict: [String: UIView] = [:]
    let colorsArray: [UIColor] = [.blue, .brown, .cyan, .darkGray, .green, .link, .magenta, .orange, .purple, .red, .systemIndigo]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAndApplyGrid()
        self.addPanGessture()
    }
    var selectedLastView: UIView? = nil
    //MARK:- Create Grid
    fileprivate func createAndApplyGrid() {
        let numberOfItemsInRow = Int(self.view.frame.width/width)
        let numberOfRows = Int(self.view.frame.height/width)
        var yPosition = self.navigationController?.navigationBar.frame.maxY ?? 70
        for j in 0...numberOfRows {
            yPosition = width*CGFloat(j)
            for i in 0...numberOfItemsInRow {
                let view = UIView(frame: CGRect(x: CGFloat(i)*width, y: yPosition, width: width, height: width))
                view.layer.borderColor = UIColor.black.cgColor
                view.layer.borderWidth = 1.0
                if  let color = self.colorsArray.randomElement() {
                    view.backgroundColor = color
                }
                self.view.addSubview(view)
                let key = "\(i)\(j)"
                viewHolderDict[key] = view
            }
        }
    }
    
    //MARK:- add gesture
    fileprivate func addPanGessture(){
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture(gesture:))))
    }
    
    //MARK:- Spring animation reset to identity
    fileprivate func setBackToIdentity(_ perviousView: UIView, _ delay: TimeInterval)  {
        //Resset identity for last view
        UIView.animate(withDuration: 0.5, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut) {
            perviousView.transform = .identity
        } completion: { (_) in }
    }
    
    //MARK:- Spring animation with supplied scale
    fileprivate func applySpringAnimation(_ currentView: UIView, _ scale: CGFloat) {
        //Reset identity for current view
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut) {
            currentView.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { (_) in }
    }
    
    //MARK:- PanGesture selector
    @objc fileprivate func panGesture(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)
        let i = (Int(location.x/width))
        let j = (Int(location.y/width))
        
        let key = "\(i)\(j)"
        if let currentView = self.viewHolderDict[key] {
          if let perviousView = selectedLastView, perviousView != currentView {
            setBackToIdentity(perviousView, 0.1)
            }
            selectedLastView = currentView
            //2. Bring current view on superview
            self.view.bringSubviewToFront(currentView)
            applySpringAnimation(currentView, 1.8)
            
            switch gesture.state {
            case .ended:
                applySpringAnimation(currentView, 2.4)
                setBackToIdentity(currentView, 1.0)
            default:
                break
            }
        }
    }
}
