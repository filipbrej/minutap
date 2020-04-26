//
//  MenuButton.swift
//  minutap-game
//
//  Created by Filip Brej on 3/19/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit


// Button used on the main menu screen
class MenuButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Custom initializer for button
    convenience init(title: String, backgroundColor: UIColor, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: fontSize)
    }
    
    // Configure button shape and size
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        setTitleColor(.white, for: .normal)
    }
}
