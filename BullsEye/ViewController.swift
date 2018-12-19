//
//  ViewController.swift
//  practise
//
//  Created by Samantha Bull on 28/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0 {
        didSet {
            targetLabel.text = "Move the Bull's Eye as close as you can to: \(targetValue)"
        }
    }
    
    var round: Int = 0 {
        didSet {
            roundLabel.text = "Round: \(round)"
        }
    }
    
    var totalScore: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(totalScore)"
        }
    }
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
        
        startNewRound()
    }
    
    @IBAction func hitMe() {
        var difference: Int = targetValue - currentValue
        if (difference < 0) {
            difference = 0 - difference
        }
        var score = 100 - difference
        
        let title: String
        if (difference == 0) {
            title = "Bullseye!"
            score += 50
        }
        else if (difference < 5) {
            title = "So close!"
        }
        else if (difference < 10) {
            title = "Nice!"
            score -= difference
        }
        else if (difference < 25) {
            title = "Your aim needs work..."
            score -= Int(Double(difference)*1.5)
        }
        else {
            title = "Nowhere near!"
            score = 0
        }
        
        let alert = UIAlertController(title: title, message: "You scored \(score) points", preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: { action in self.startNewRound() })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        totalScore += score
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
    
    @IBAction func restart() {
        round = 0
        totalScore = 0
        startNewRound()
    }
    
    func startNewRound() {
        round = round + 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
}

