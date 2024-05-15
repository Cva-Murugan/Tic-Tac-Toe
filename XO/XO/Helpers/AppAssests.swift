//
//  AppAssests.swift
//  SampleTTG
//
//  Created by John Michael on 09/04/24.
//

import Foundation
import UIKit

final class AppAssets{
    
    public static let shared = AppAssets()
    
    // common colors
    let xBackgroundColor:UIColor = .systemRed
    let oBackgroundColor:UIColor = .systemYellow
    let xMarkColor:CGColor = UIColor.systemYellow.cgColor
    let oMarkColor:CGColor = UIColor.white.cgColor
    
    let font : UIFont = UIFont(name: "Bungee-Regular", size: 20) ?? .systemFont(ofSize: 20)
    
}


