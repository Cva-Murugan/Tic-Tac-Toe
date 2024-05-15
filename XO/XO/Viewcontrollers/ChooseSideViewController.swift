//
//  ChooseSideViewController.swift
//  SampleTTG
//
//  Created by John Michael on 08/04/24.
//

import UIKit

class ChooseSideViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var xoStackView: UIStackView!
    
    @IBOutlet weak var oView: UIView!
    
    @IBOutlet weak var xView: UIView!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    var playmode = ""
    var choosenSide = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        gradientView.backgroundColor = .clear
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.yellow.cgColor,UIColor.red.cgColor]
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        xView.layer.cornerRadius = 25
        oView.layer.cornerRadius = 25
        xView.backgroundColor = .systemRed
        oView.backgroundColor = .systemYellow
        
        drawXMark(on: xView)
        drawOMark(on: oView)
        
        for subview in xoStackView.arrangedSubviews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            subview.addGestureRecognizer(tapGesture)
        }
        
        startGameButton.addTarget(self, action: #selector(startTheGame), for: .touchUpInside)
    
    }
    
    
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
        // Remove highlight effect from all other views
        for subview in xoStackView.arrangedSubviews {
            if subview != tappedView {
                removeHighlight(from: subview)
            }
        }
        
        if tappedView == xView {
            choosenSide = "X"
        } else {
            choosenSide = "O"
        }
        
        // Create a highlight layer for the tapped view
        let highlightLayer = createHighlightLayer(for: tappedView)
        
        // Apply the glow effect to the tapped view
        applyGlowEffect(to: highlightLayer)
    }

    // Function to remove highlight effect from a view
    private func removeHighlight(from view: UIView) {
        guard let layers = view.layer.sublayers else { return }
        for layer in layers {
            if layer.name == "highlightLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }

    // Function to create a highlight layer for a view
    private func createHighlightLayer(for view: UIView) -> CALayer {
        let highlightLayer = CALayer()
        highlightLayer.bounds = view.bounds.insetBy(dx: 0, dy: 0)
        highlightLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        highlightLayer.backgroundColor = UIColor.clear.cgColor
        highlightLayer.cornerRadius = view.layer.cornerRadius
        highlightLayer.borderColor = UIColor.black.cgColor
        highlightLayer.borderWidth = 5 // Adjust the width of the border as needed
        highlightLayer.name = "highlightLayer"
        view.layer.addSublayer(highlightLayer)
        return highlightLayer
    }

    // Function to apply glow effect to a layer
    private func applyGlowEffect(to layer: CALayer) {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.5
        pulseAnimation.fromValue = 0.8
        pulseAnimation.toValue = 0.0
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        pulseAnimation.repeatCount = 1
        pulseAnimation.autoreverses = false
        pulseAnimation.isRemovedOnCompletion = true
        layer.add(pulseAnimation, forKey: "pulse")
    }

    
    func drawXMark(on view: UIView) {
        let path = UIBezierPath()
                
        let width = view.width
        let height = view.height
        let val = 45
        
        
        let cenX1 = Int(width) / 2  - val
        let cenX2 = Int(width) / 2  + val
        _ = Int(height) / 2 - val
        _ = Int(height) / 2 + val
        
        let startX1 = 0
        let startY1 = 0
        let endX1 = width
        let endY1 = height
        
        print(startX1,startY1,endX1,endY1)
        
        _ = 0
        let startY2 = 0
        _ = width
        let endY2 = height
        
        
        //Draw the lines of the "X"
        path.move(to: CGPoint(x: cenX1  , y: startY1 + val))
        path.addLine(to: CGPoint(x: cenX2, y: (Int(endY1) - val)  ))
        
        path.move(to: CGPoint(x: cenX2 , y: startY2 + val ))
        path.addLine(to: CGPoint(x: cenX1 , y: Int(endY2) - val ))
        
        
        // Create a shape layer for the path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemYellow.cgColor // Set the color of the "X"
        shapeLayer.lineWidth = 20 // Set the line width
        
        // Add the shape layer to the view's layer
        view.layer.addSublayer(shapeLayer)
        
    }
    
    
    func drawOMark(on view: UIView) {
        let centerX = view.bounds.midX
        let centerY = view.bounds.midY
        let radius = min(view.bounds.width, view.bounds.height) / 3 // Adjust the radius as needed
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor // Set the color of the circle outline
        shapeLayer.fillColor = UIColor.clear.cgColor // Set the fill color to transparent
        shapeLayer.lineWidth = 20 // Set the line width of the circle outline
        
        view.layer.addSublayer(shapeLayer)
    }
    
    
    @objc func startTheGame(){
        
        if choosenSide != "" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "VC") as! ViewController
            vc.playmode = playmode
            vc.choosenSide = choosenSide
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
