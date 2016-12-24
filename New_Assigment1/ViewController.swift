//
//  ViewController.swift
//  New_Assigment1
//
//  Created by Younoussa Ousmane Abdou on 12/20/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables and Constants
    private var userIsCurrentlyTypping = false
    
    private var displayValue: Double {
        
        get {
            
            return Double(display.text!)!
        }
        set {
            
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    // Outlets
    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var upperDisplay: UILabel!
    
    // Actions
    @IBAction private func touchDigit(sender: UIButton) {
        
        // Display Label
        let digit = sender.currentTitle!
        
        if userIsCurrentlyTypping {
            
            let currentDigitOfTyping = display.text! + digit
            
            display.text = currentDigitOfTyping
        } else {
            
            display.text = digit
        }
        
        userIsCurrentlyTypping = true
        
        // UpperDisplay Label
        
        // Success (6)
        if brain.isPartialResult == false {
            
            upperDisplay.text = brain.description + "="
        } else {
            
            upperDisplay.text = brain.description + "..."
        }
        
        
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        
        if userIsCurrentlyTypping {
            
            brain.setOperand(operand: displayValue)
            
            userIsCurrentlyTypping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle {
            
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        
        displayValue = brain.result
    }
    
    // Success (8)
    @IBAction private func touchClear(sender: UIButton) {

        display.text = " "
        upperDisplay.text = " "
    }
}

