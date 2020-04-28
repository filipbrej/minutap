//
//  InstructionsAlertViewController.swift
//  minutap
//
//  Created by Filip Brej on 4/25/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

protocol InstructionsAlertVCDelegate {
    func removeBlurView()
}

// Alert that pops up to show the instructions
class InstructionsAlertViewController: UIViewController {
    
    // MARK: - UI Elements
    let containerView = AlertContainerView()
    let titleView = UIView()
    
    let titleLabel = AlertTitleLabel(fontSize: 30, textAlignment: .center)
    let messageLabel = AlertMessageLabel(fontSize: 20, textAlignment: .left)
    let actionButton = AlertButton(title: "OK", fontSize: 25)
  
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: InstructionsAlertVCDelegate?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureTitleView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
    }
    
    // MARK: - Configure UI elements
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 420),
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
        titleLabel.text = "HOW TO PLAY"
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
          ])
    }
    
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = "Press the \"Tap\" button as many times as you can in one minute and achieve a high score. \n\nOnce time runs out, you can play again or exit and play again later. \n\nGood luck and have fun!"
        
        messageLabel.numberOfLines = 0
          
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 45),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            
            
        ])
    }
    
    // MARK: - Selector functions
    @objc func dismissViewController() {
        delegate?.removeBlurView()
        dismiss(animated: true)
    }
}
