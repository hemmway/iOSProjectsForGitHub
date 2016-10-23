//
//  ViewController.swift
//  TargetPunch
//
//  Created by Ivan Kurhanskyi on 10/21/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var targetValue: Int = 0
    var currentValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func showAlert() {
        
        let difference = abs(targetValue-currentValue)
        var points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect Punch 👊🏻"
            points += 100
        } else if difference < 5 {
            title = "So close...👍🏻"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good 👌🏻"
        } else {
            title = "Sucked Punch 👎🏻"
        }
        score += points

        let message = "You've punched \(currentValue)" + "\nYou scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Hell, Yeah!", style: .default, handler: { action in
                self.startNewRound()
                self.updateLabels()
        })
        
        alert.addAction(action)
        
        // Make the alert visible:
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    
    
    func startNewRound() {
        round += 1
        targetValue = Int(arc4random_uniform(100))
        currentValue = Int(slider.value)
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    func startNewGame() {
        round = 0
        score = 0
        slider.value = 50
        startNewRound()
    }
}

