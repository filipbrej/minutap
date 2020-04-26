//
//  Animations.swift
//  minutap-game
//
//  Created by Filip Brej on 3/21/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit


// Animations for buttons
extension UIButton {
    
    // Add spring animation when button is pressed
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 1.0
        pulse.toValue = 0.90
        pulse.autoreverses = true
        pulse.initialVelocity = 0.5
        
        layer.add(pulse, forKey: nil)
    }
}


// Animations for labels
extension UILabel {
    
    func expand() {
        let expansion = CASpringAnimation(keyPath: "transform.scale")
        expansion.duration = 0.1
        expansion.fromValue = 1.0
        expansion.toValue = 1.7
        expansion.autoreverses = true
        expansion.initialVelocity = 1.0
        
        layer.add(expansion, forKey: nil)
    }
}
