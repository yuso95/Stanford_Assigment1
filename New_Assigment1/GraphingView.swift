//
//  GraphingView.swift
//  New_Assigment1
//
//  Created by Younoussa Ousmane Abdou on 1/9/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

@IBDesignable
class GraphingView: UIView {
    
    @IBInspectable var scale: CGFloat = 0.9 { didSet { setNeedsLayout() } }
    @IBInspectable var lineWidth: CGFloat = 1 { didSet { setNeedsLayout() } }
    @IBInspectable var redColor: UIColor = UIColor.red { didSet { setNeedsLayout() } }
    // For UITapGestureRecognizer
    @IBInspectable var showCircle: Bool = true { didSet { setNeedsLayout() } }
    
    // Circle
    var circleCenter: CGPoint {
        
        return CGPoint(x: bounds.midX, y: bounds.maxY - 50)
    }
    
    var circleRadius: CGFloat {
        
        return CGFloat(bounds.maxX / 2) * scale
    }
    
    // Horizontal line
    var horizontalLineOrigin: CGPoint {
        
        return CGPoint(x: bounds.minX, y: bounds.midY)
    }
    
    //Vertical line
    var verticalLineOrigin: CGPoint {
        
        return CGPoint(x: bounds.midX, y: bounds.minY)
    }
    
    override func draw(_ rect: CGRect) {
        
        // Circle
        
        if showCircle {
            
            let circle = pathForCircle(center: circleCenter, radius: circleRadius)
            circle.lineWidth = lineWidth
            circle.stroke()
        } else {
            
            
        }
        
        // Horizontal line
        
        let horizontalLine = pathForStraightHorizontalVerticalLine(origin: horizontalLineOrigin, width: 0, height: 0)
        horizontalLine.lineWidth = lineWidth
        horizontalLine.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        horizontalLine.stroke()
        
        // Vertical line
        let verticalLine = pathForStraightHorizontalVerticalLine(origin: verticalLineOrigin, width: 0, height: 0)
        verticalLine.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        verticalLine.lineWidth = lineWidth
        verticalLine.stroke()
        
    }
    
    // PinchGestureRecognizer functions
    
    func changeScale(recognizer: UIPinchGestureRecognizer) {
        
        switch recognizer.state {
        case .changed:
            
            scale = recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    // Path for Any Shapes
    
    private func pathForCircle(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        redColor.set()
        
        return path
    }
    
    private func pathForStraightHorizontalVerticalLine(origin: CGPoint, width: CGFloat, height: CGFloat) -> UIBezierPath {
        
        let horizontalRect = CGRect(origin: origin, size: CGSize(width: width, height: height))
        
        let path = UIBezierPath(rect: horizontalRect)
        
        redColor.set()
        
        return path
        
    }
}
