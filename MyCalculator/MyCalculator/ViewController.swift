//
//  ViewController.swift
//  MyCalculator
//
//  Created by Ivan Kurganskiy on 8/16/16.
//  Copyright © 2016 Ivan Kurganskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
        dotIsPlaced = false
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.componentsSeparatedByString(".")
            if valueArray[1] == "0" {
                display.text = "\(valueArray[0])"
            } else {
            display.text = String(newValue)
            }
        }
    }
    
    
    private var brain = CalcBrain()
    
    @IBAction private func actionPerformed(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
    }
    
    private var dotIsPlaced = false
    
    @IBAction func dotButtonPressed(sender: UIButton) {
        if userIsInTheMiddleOfTyping && !dotIsPlaced {
            display.text = display.text! + "."
            dotIsPlaced = true
        } else if !userIsInTheMiddleOfTyping && !dotIsPlaced {
            display.text = "0."
        }
        
    }
    
    @IBAction func cleanUP(sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        display.text! = "0"
        dotIsPlaced = false
        brain.clean()
    }
}

