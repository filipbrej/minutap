//
//  ViewController.swift
//  minutap-game
//
//  Created by Filip Brej on 3/19/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
//    MARK: - UI Elements
    
    // Labels
    let titleLabel = MenuPrimaryLabel(text: "MINUTAP", fontSize: 50.0)
    let footerLabel = MenuSecondaryLabel(text: "Designed & Developed by Filip Brej", fontSize: 16.0)
    
    // Top half view
    let topHalfView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 30
        return view
    }()
    
    // Buttons 
    let playButton = MenuButton(title: "Play Game", backgroundColor: .systemPurple, fontSize: 30)
    let instructionsButton = MenuButton(title: "How to Play", backgroundColor: .systemPurple, fontSize: 30)
    
    
    var menuButtons: [MenuButton] = []
    
//    MARK: - Lifecycle Methods and Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUILayout()
        configureNavigationBar()
        handleButtonsTapped()
    }
    

    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemPurple
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    // Buttons will present view controllers when tapped
    func handleButtonsTapped() {
        playButton.addTarget(self, action: #selector(pushGameViewController), for: .touchUpInside)
        instructionsButton.addTarget(self, action: #selector(presentInstructionsViewController), for: .touchUpInside)
    }
    
//    MARK: - UI Constraints
    // Setup UI layout
    func configureUILayout() {
        
        // Add top half view to subview
        view.addSubview(topHalfView)
        // Add buttons to parent view
        view.addSubviews(playButton, instructionsButton)
        menuButtons = [playButton, instructionsButton]
        
        // Set common attributes for each menu button
        for button in menuButtons {
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalToConstant: 200)
            ])
        }
        
        // Add labels to parent view
        view.addSubviews(titleLabel, footerLabel)
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            
            // Top half view constraints
            topHalfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            topHalfView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50),
            topHalfView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topHalfView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // Footer label constraints
            footerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            footerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Menu button constraints
            playButton.topAnchor.constraint(equalTo: topHalfView.bottomAnchor, constant: 40),
            instructionsButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: padding),
        ])
    }
    
       
    //    MARK: - Selectors
        
        @objc func pushGameViewController() {
            let destinationVC = GameViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
        
        @objc func presentInstructionsViewController() {
            
            let blurView = UIVisualEffectView()
            blurView.frame = view.frame
            blurView.effect = UIBlurEffect(style: .dark)
            view.addSubview(blurView)
            let alertVC = InstructionsAlertViewController()
            alertVC.delegate = self
            alertVC.modalPresentationStyle = .custom
            self.present(alertVC, animated: true, completion: nil)
        }
}


// MARK: - Extensions
extension MenuViewController: InstructionsAlertVCDelegate {
    func removeBlurView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    
}

