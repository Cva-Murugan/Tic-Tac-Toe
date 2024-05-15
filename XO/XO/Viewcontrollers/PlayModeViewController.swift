//
//  PlayModeViewController.swift
//  SampleTTG
//
//  Created by John Michael on 08/04/24.
//

import UIKit

class PlayModeViewController: UIViewController {

    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var aiButton: UIButton!
    
    @IBOutlet weak var friendButton: UIButton!
    
    var playMode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        gradientView.backgroundColor = .clear
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.black
        
        for (index, subview) in buttonStackView.arrangedSubviews.enumerated() {
            if let button = subview as? UIButton {
                button.tag = index
                button.addTarget(self, action: #selector(playModeChoosing(_:)), for: .touchUpInside)
            }
        }
        
    }
    
    @objc func playModeChoosing(_ sender: UIButton) {
        // Retrieve the tag to determine which button was tapped
        let tappedButtonTag = sender.tag
        print("Button with tag \(tappedButtonTag) tapped.")
        
        if tappedButtonTag == 0 {
            playMode = "bot"
        } else if tappedButtonTag == 1 {
            playMode = "friend"
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "choosesideVC") as! ChooseSideViewController
        vc.playmode = playMode
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
