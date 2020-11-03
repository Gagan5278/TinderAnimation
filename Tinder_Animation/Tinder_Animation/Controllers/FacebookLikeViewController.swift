//
//  FacebookLikeViewController.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 11/3/20.
//

import UIKit

class FacebookLikeViewController: UIViewController {
    fileprivate let kPadding: CGFloat = 4.0
    fileprivate let kPaddingConstant : CGFloat = 15.0
    fileprivate let constantWidhtHeight: CGFloat = 40.0
    fileprivate var previousSelectedImageView: UIImageView? = nil
    fileprivate lazy var viewPopOver: ShadowView = {
        let view = ShadowView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        let allArrangedSubViews =  [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6")].map { (img) -> UIView in
            var viewObj = UIImageView()
            viewObj.isUserInteractionEnabled = true
            viewObj.image = img
            return viewObj
        }
        let stackView = UIStackView(arrangedSubviews: allArrangedSubViews)
        stackView.spacing = kPadding
        stackView.distribution = .fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: kPadding, left: kPadding, bottom: kPadding, right: kPadding)
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        view.backgroundColor = .white
        view.frame.size.height = 2*kPadding + constantWidhtHeight
        view.frame.size.width = CGFloat(allArrangedSubViews.count) * constantWidhtHeight  + CGFloat(allArrangedSubViews.count - 1) * kPadding
        view.layer.cornerRadius = view.frame.size.height/2.0
        stackView.frame = view.frame
        return view
    }()
    
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //title
        self.title = "Facebook Like Animation"
        //Set image as patten color
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bgImage"))
        //add Long Gesture
        self.addLongGestureOnView()
    }
        
    //MARK:- Add Long Gesture
    fileprivate func addLongGestureOnView() {
        self.view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didLongPreess(gesture:))))
    }
    
    //MARK:- Long Gesture action
    @objc fileprivate func didLongPreess(gesture: UILongPressGestureRecognizer) {
        let constantForAnimation = self.viewPopOver.frame.height + self.kPaddingConstant
        let location = gesture.location(in: self.view)
        
        switch gesture.state {
        case .began:
            self.addPopupAnimation(location, constantForAnimation)
        case .ended:
            if let imgViewPreviuos = self.previousSelectedImageView{
               imgViewPreviuos.transform = .identity
            }
            self.viewPopOver.removeFromSuperview()
        case .changed:
            self.changedAnimation(gesture: gesture)
        default:
            break
        }
    }
    
    //MARK:- Chnaged animation
    fileprivate func changedAnimation(gesture: UILongPressGestureRecognizer){
        let location = gesture.location(in: self.viewPopOver)

        if let imgView = self.viewPopOver.hitTest(location, with: nil) as? UIImageView {
            if let imgViewPreviuos = self.previousSelectedImageView,  imgView != imgViewPreviuos{
                UIView.animate(withDuration: 0.5) {
                    imgViewPreviuos.transform = .identity
                }
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut) {
                imgView.transform = CGAffineTransform(translationX: 0, y: -self.constantWidhtHeight)
                self.previousSelectedImageView = imgView
            }

        }
    }
    
    //MARK:- Pop up animation
    fileprivate func addPopupAnimation(_ location: CGPoint, _ constantForAnimation: CGFloat) {
        let centeredX = (self.view.frame.width - self.viewPopOver.frame.width)/2.0
        self.viewPopOver.transform  = CGAffineTransform(translationX: centeredX, y: location.y)
        self.viewPopOver.alpha = 0.1
        self.view.addSubview(self.viewPopOver)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut) { [self] in
            self.viewPopOver.alpha = 0.3
            self.viewPopOver.transform  = CGAffineTransform(translationX: centeredX, y: location.y - constantForAnimation)
            UIView.animate(withDuration: 0.3) {
                self.viewPopOver.alpha = 1.0
            }
        }
    }
}
