//
//  GameAlertView.swift
//  minutap
//
//  Created by Filip Brej on 4/25/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

class AlertContainerView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemPurple
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
    }
}
