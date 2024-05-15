//
//  Colors.swift
//  Calculator
//
//  Created by John Michael on 25/03/24.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension UIView{
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.size.height + frame.origin.y
    }
    
    public var right: CGFloat {
        return frame.origin.x
    }
    
    public var left: CGFloat {
        return frame.size.width + frame.origin.x
    }
    
    
}



extension UIView {
    func addDashedBorders() {
        
        let color = UIColor(named:"borderColor")?.cgColor ?? UIColor.red.cgColor
        
        // Add horizontal dashed lines
        for i in 1...2 {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 2
            //shapeLayer.lineDashPattern = [6,2]
            
            let startPoint = CGPoint(x: 10, y: (frame.size.height / 3) * CGFloat(i))
            let endPoint = CGPoint(x: frame.size.width - 10, y: (frame.size.height / 3) * CGFloat(i))
            
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            
            shapeLayer.path = path.cgPath
            layer.addSublayer(shapeLayer)
        }
  
        
        // Add vertical dashed lines
        for i in 1...2 {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 2
            //shapeLayer.lineDashPattern = [6,2]
            
            let startPoint = CGPoint(x: (frame.size.width / 3) * CGFloat(i) , y: 10)
            let endPoint = CGPoint(x: (frame.size.width / 3) * CGFloat(i), y: frame.size.height - 10)
            
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            
            shapeLayer.path = path.cgPath
            layer.addSublayer(shapeLayer)
        }
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: -5, y: -5, width: frameSize.width + 5, height: frameSize.height + 5)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,2]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    
}

