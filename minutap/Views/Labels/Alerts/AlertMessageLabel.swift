//
//  AlertMessageLabel.swift
//  minutap-game
//
//  Created by Filip Brej on 3/23/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

class AlertMessageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(fontSize: CGFloat, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.font = UIFont(name: "MarkerFelt-Wide", size: fontSize)
        self.textAlignment = textAlignment
    }
    
    
    // Title label properties
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
