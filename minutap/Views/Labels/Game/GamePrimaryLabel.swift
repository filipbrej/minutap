//
//  GamePrimaryLabel.swift
//  minutap-game
//
//  Created by Filip Brej on 3/23/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

class GamePrimaryLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Initialize label
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont(name: "GillSans-Bold", size: fontSize)
    }
    
    
    // Configure label properties
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
    }

}
