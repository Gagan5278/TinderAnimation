//
//  CircularDownloadViewController.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 11/1/20.
//

import UIKit

class CircularDownloadViewController: UIViewController {

    let trackLayer : CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    let progressLayer : CAShapeLayer = {
        return CAShapeLayer()
    }()
    let networking = Networking()
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addCircles()
    }
    
    //MARK:- Add circle
    fileprivate func addCircles() {
        addTrackAnimationLayer()

        addTrackLayer()
        addProgressLayer()
    }
    
    
    fileprivate func addTrackLayer() {
        let strokeColorTrack = UIColor.lightGray.cgColor
        let fillColorTrack = UIColor.black.cgColor
        createAndAddLayer(trackLayer, fillColorTrack, strokeColorTrack)
    }
    
    fileprivate func addTrackAnimationLayer() {
        let strokeColorTrack = UIColor.purple.withAlphaComponent(0.5).cgColor
        let fillColorTrack = UIColor.purple.withAlphaComponent(0.5).cgColor
        let layer = CAShapeLayer()
        createAndAddLayer(layer, fillColorTrack, strokeColorTrack)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.1
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        layer.add(animation, forKey: "sclae")
    }

    
    fileprivate func addProgressLayer() {
        let strokeColor = UIColor.purple.cgColor
        let fillColor = UIColor.clear.cgColor
        createAndAddLayer(progressLayer,fillColor, strokeColor)
        progressLayer.transform = CATransform3DMakeRotation( -CGFloat.pi/2, 0, 0, 1)
        progressLayer.strokeEnd = 0.0
    }
    
    fileprivate func createAndAddLayer(_ shapLayer: CAShapeLayer, _ fillColor: CGColor, _ strokeColor: CGColor) {
        //Create shape layer
        let path = UIBezierPath(arcCenter: .zero, radius: 100.0, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)
        shapLayer.position = self.view.center
        shapLayer.path = path.cgPath
        shapLayer.fillColor = fillColor
        shapLayer.strokeColor = strokeColor
        shapLayer.strokeStart = 0.0
        shapLayer.lineWidth = 10.0
        shapLayer.lineCap = .round
        shapLayer.strokeEnd = 1.0
        //Add shape layer on View
        self.view.layer.addSublayer(shapLayer)
    }
    
    
    @IBAction func downloadButtonCliked(_ sender: Any) {
        self.progressLayer.strokeEnd = 0.0
        self.networking.downloadVideoFile()
        self.networking.dowbloadPreogressBlock = { [weak self](progress) in
            self?.progressLayer.strokeEnd =  CGFloat(progress)
        }
    }
}
