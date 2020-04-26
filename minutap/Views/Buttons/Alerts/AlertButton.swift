//
//  AlertButton.swift
//  minutap-game
//
//  Created by Filip Brej on 3/23/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

class AlertButton: UIButton {

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
    
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        // Custom initializer for button
        convenience init(title: String, fontSize: CGFloat) {
            self.init(frame: .zero)
            self.backgroundColor = .white
            self.setTitle(title, for: .normal)
            self.setTitleColor(UIColor.systemPurple, for: .normal)
            self.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: fontSize)
        }
        
        // Configure button shape and size
        private func configure() {
            translatesAutoresizingMaskIntoConstraints = false
            layer.cornerRadius = 20
            setTitleColor(.white, for: .normal)
        }
}
