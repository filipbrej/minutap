//
//  GameViewController.swift
//  minutap-game
//
//  Created by Filip Brej on 3/19/20.
//  Copyright © 2020 Filip Brej. All rights reserved.
//



import UIKit

class GameViewController: UIViewController {
    
    //    MARK: - UI Elements
    
    // Labels
    var scoreLabel = GamePrimaryLabel(fontSize: 48.0)
    var timeRemainingLabel = GamePrimaryLabel(fontSize: 24.0)
    var highScoreLabel = GamePrimaryLabel(fontSize: 24.0)
    var readySetGoLabel = GamePrimaryLabel(fontSize: 40)
    var hintLabel = GameSecondaryLabel(text: "Press the button below to start.", fontSize: 20)
    
    
    // Buttons
    var increaseScoreButton = ScoreButton(title: "TAP", fontSize: 30.0, backgroundColor: .systemPurple)
    
    //    MARK: - UI Element Values
    // Score values
    private var currentScore: Int = 0
    private var highScore: Int = 0
    
    
    // Timers for each round
    private var roundTimer: Timer?
    private var timeLeft: Int = 60
    
    
    // Countdown timer
    private var countdownTimer: Timer?
    private var countdown: Int = 5
    
    //    MARK: - View Lifecycle and Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        configureIncreaseScoreButton()
        setLabelsText()
        setupCountdownTimer()
        configureNavigationBar()
        
        let highScoreDefault = UserDefaults.standard
        if (highScoreDefault.value(forKey: "Highscore") != nil) {
            highScore = highScoreDefault.value(forKey: "Highscore") as! Int
            highScoreLabel.text = "High Score: \(highScore)"
        }
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemPurple
        navigationController?.navigationBar.tintColor = .white
    }
    
    //    MARK: - UI Constraints
    // Set up label constraints
    func configureLabels() {
        view.backgroundColor = .systemBackground
        view.addSubviews(highScoreLabel, timeRemainingLabel, readySetGoLabel, scoreLabel, hintLabel, increaseScoreButton)
        
        NSLayoutConstraint.activate([
            
            // Score label constraints
            highScoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            highScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            highScoreLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            // Timer label constraints
            timeRemainingLabel.topAnchor.constraint(equalTo: highScoreLabel.bottomAnchor, constant: 10),
            timeRemainingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            timeRemainingLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            // Countdown label constraints
            readySetGoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readySetGoLabel.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 50),
            
            
            // Score label constraints
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: increaseScoreButton.topAnchor, constant: -80),
            
            
            // Hint label constraints
            hintLabel.bottomAnchor.constraint(equalTo: increaseScoreButton.topAnchor, constant: -20),
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    // Configure increase score button
    func configureIncreaseScoreButton() {
        disableIncreaseScoreButton()
        
        // Increase the score when the button is tapped
        increaseScoreButton.addTarget(self, action: #selector(increaseScore), for: .touchUpInside)
        
        let buttonDimension: CGFloat = 150.0
        let buttonRadius = buttonDimension / 2
        increaseScoreButton.layer.cornerRadius = buttonRadius
        
        NSLayoutConstraint.activate([
            
            increaseScoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            increaseScoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            increaseScoreButton.heightAnchor.constraint(equalToConstant: buttonDimension),
            increaseScoreButton.widthAnchor.constraint(equalToConstant: buttonDimension),
            
        ])
    }
    
    //    MARK: - UI Functions
    
    // Change background color of time remaining label depending on amount of time left (changes every 20 seconds)
    func changeTimeRemainingLabel() {
        if (timeLeft <= 40 && timeLeft > 20) {
            timeRemainingLabel.textColor = .systemOrange
        }
        else if (timeLeft <= 20) {
            timeRemainingLabel.textColor = .systemRed
            if (timeLeft <= 10) {
                timeRemainingLabel.expand()
            }
        }
        else {
            timeRemainingLabel.textColor = .systemGreen
        }
    }
    
    
    func enableIncreaseScoreButton() {
        increaseScoreButton.isEnabled = true
        increaseScoreButton.backgroundColor = .systemPurple
    }
    
    
    func disableIncreaseScoreButton() {
        increaseScoreButton.isEnabled = false
        increaseScoreButton.backgroundColor = .systemGray
    }
    
    
    // Set text for labels as conditions change
    func setLabelsText() {
        scoreLabel.text = "\(currentScore)"
        highScoreLabel.text = "High Score: \(highScore)"
        timeRemainingLabel.text = "Time remaining: \(timeLeft)"
        timeRemainingLabel.textColor = .systemGreen
        
        if currentScore > highScore {
            highScore = currentScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
    }
    
    
    func setupCountdownTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(fireCountdownTimer), userInfo: nil, repeats: true)
    }
    
    func setupRoundTimer() {
        roundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireRoundTimer), userInfo: nil, repeats: true)
    }
    
    
    func presentGameOverViewController() {
        let blurView = UIVisualEffectView()
        blurView.frame = view.frame
        blurView.effect = UIBlurEffect(style: .dark)
        view.addSubview(blurView)
        let alertVC = GameOverAlertViewController()
        alertVC.delegate = self
        alertVC.modalPresentationStyle = .custom
        self.present(alertVC, animated: true, completion: nil)
        
        alertVC.playAgainButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        alertVC.messageLabel.text = "Your total score is \(currentScore).\nCare to play again?"
        
    }
    
    
    //    MARK: - Selectors
    @objc func fireCountdownTimer() {
        countdown -= 1
        
        if (countdown <= 5 && countdown >= 3) {
            readySetGoLabel.text = "Ready?"
        } else if (countdown <= 2 && countdown >= 1) {
            readySetGoLabel.text = "Set..."
        } else if (countdown < 1) {
            readySetGoLabel.text = "GO!"
            countdownTimer?.invalidate()
            setupRoundTimer()
            enableIncreaseScoreButton()
        }
    }
    
    @objc func fireRoundTimer() {
        timeLeft -= 1
        timeRemainingLabel.text = "Time remaining: \(timeLeft)"
        
        if (timeLeft <= 58) {
            readySetGoLabel.text = nil
        }
        
        // Stop timer and disable button when timer reaches 0
        if (timeLeft == 0) {
            presentGameOverViewController()
            disableIncreaseScoreButton()
            roundTimer?.invalidate()
        }
        changeTimeRemainingLabel()
        
    }
    
    // Increases score when button is tapped
    @objc func increaseScore() {
        
        // UI animations
        increaseScoreButton.pulsate()
        scoreLabel.expand()
        
        // Adjust scores
        currentScore += 1
        scoreLabel.text = "\(currentScore)"
        highScoreLabel.text = "High Score: \(highScore)"
        
        // Set high score if new one is reached
        if (currentScore > highScore) {
            highScoreLabel.expand()
            highScore = currentScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        
        // Hide hint label once player begins
        if (currentScore >= 1) {
            hintLabel.text = nil
        }
        
        // Save high score even when the user quits the appilcation
        let highScoreDefault = UserDefaults.standard
        highScoreDefault.setValue(highScore, forKey: "Highscore")
        highScoreDefault.synchronize()
    }
    
    // Reset the timer, countdown, and current score
    @objc func resetGame() {
        timeLeft = 60
        countdown = 5
        currentScore = 0
        scoreLabel.text = nil
        setupCountdownTimer()
        setLabelsText()
    }
    
}

// MARK: - Extensions

extension GameViewController: GameOverAlertVCDelegate {
    func removeBlurView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
}
