//
//  StickerContainerView.swift
//  PhotoEditor
//
//  Created by Chinmoy Biswas on 6/5/22.
//

import UIKit

class StickerContainerView: UIView {

    var initFrame: CGRect?
    var lastRotation: CGFloat = 0
    var maxFrame: CGRect?

    init(frame: CGRect, image: UIImage, maxFrame: CGRect) {
        super.init(frame: frame)
        
        let imgView = UIImageView(frame: self.bounds)
        imgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(imgView)
        imgView.image = image
        self.maxFrame = maxFrame
        
        /// Gestures
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        pinchGesture.delegate = self
        self.addGestureRecognizer(pinchGesture)
        
//        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotatedView(_:)))
//        rotateGesture.delegate = self
//        self.addGestureRecognizer(rotateGesture)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func wasDragged(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.superview)
        if let image = gesture.view {
            
            //self.bringSubviewToFront(image)
            
            var x = (image.center.x) + translation.x
            var y = (image.center.y) + translation.y
            print(x, y)
            if let maxFrame = maxFrame {
                
                let imageCnterX = image.width/2
                
                if x >= maxFrame.width - imageCnterX || x <= imageCnterX {
                    if x >= maxFrame.width - imageCnterX {
                        x = maxFrame.width - (imageCnterX)
                    }
                    else if x <= imageCnterX {
                        x = imageCnterX
                    }
                }
                
                let imageCnterY = image.height/2
                
                if y >= maxFrame.height - imageCnterY || y <= imageCnterY {
                    if y >= maxFrame.height - imageCnterY {
                        y = maxFrame.height - (imageCnterY)
                    }
                    else if y <= imageCnterY {
                        y = imageCnterY
                    }
                }
            }
            
            image.center = CGPoint(x: x, y: y)
            gesture.setTranslation(CGPoint.zero, in: self.superview)
            
        }
    }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            self.initFrame = self.frame
            break
        case .changed:
            let width = self.initFrame?.width ?? .zero
            let height = self.initFrame?.height ?? .zero
            self.bounds = CGRect(x: 0, y: 0, width: width * gesture.scale, height:  height * gesture.scale)
            break
        case .ended:
            break
        default:
            break
        }
    }
    
    @objc func rotatedView(_ gesture: UIRotationGestureRecognizer) {
        
        var originalRotation = CGFloat()
        
        switch gesture.state {
        case .began:
            gesture.rotation = lastRotation
            originalRotation = gesture.rotation
            break
        case .changed:
            let newRotation = gesture.rotation + originalRotation
            self.transform = CGAffineTransform(rotationAngle: newRotation)
            break
        case .ended:
            lastRotation = gesture.rotation
            break
        default:
            break
        }
    }
}

extension StickerContainerView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
