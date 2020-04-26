//
//  MenuSecondaryLabel.swift
//  minutap-game
//
//  Created by Filip Brej on 3/23/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

class MenuSecondaryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.text = text
    }
    
    private func configure() {
        textColor = .secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
    }
}
