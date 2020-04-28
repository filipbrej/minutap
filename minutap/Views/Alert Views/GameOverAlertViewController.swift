//
//  GameOverViewController.swift
//  minutap
//
//  Created by Filip Brej on 4/25/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

protocol GameOverAlertVCDelegate {
    func removeBlurView()
}

// Alert that pops up when the timer runs out
class GameOverAlertViewController: UIViewController {
    
    // MARK: - UI Elements
    let containerView = AlertContainerView()
    let titleView = UIView()
    
    let titleLabel = AlertTitleLabel(fontSize: 30, textAlignment: .center)
    let messageLabel = AlertMessageLabel(fontSize: 25, textAlignment: .center)
    let playAgainButton = AlertButton(title: "Play Again", fontSize: 25)
    let dismissAlertButton = AlertButton(title: "No Thanks", fontSize: 25)
    
    
    var alertButtons: [AlertButton] = []
    
    
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: GameOverAlertVCDelegate?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureTitleView()
        configureTitleLabel()
        configureMessageLabel()
        configureAlertButtons()
    }
    
    
    // MARK: - Configure UI elements
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    func configureTitleView() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleView)
        titleView.backgroundColor = .white
        titleView.layer.cornerRadius = 15
        titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
    
    
    func configureTitleLabel() {
        titleView.addSubview(titleLabel)
        titleLabel.text = "TIME'S UP!"
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
    }
    
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = "Your total score is.\nCare to play again?"
        
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    
    func configureAlertButtons() {
        containerView.addSubviews(playAgainButton, dismissAlertButton)
        alertButtons = [playAgainButton, dismissAlertButton]
        
        
        for button in alertButtons {
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 45),
                button.widthAnchor.constraint(equalToConstant: 250),
                button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
        }
        
        // Functions for alert buttons
        playAgainButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        dismissAlertButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            
            playAgainButton.bottomAnchor.constraint(equalTo: dismissAlertButton.topAnchor, constant: -20),
            
            dismissAlertButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            ])
    }
    
    // MARK: - Selector functions
    @objc func dismissViewController() {
        delegate?.removeBlurView()
        dismiss(animated: true)
    }

    @objc func dismissAlert() {
        delegate?.removeBlurView()
        dismiss(animated: true)
    }
    
}
