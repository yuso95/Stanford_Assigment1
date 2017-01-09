//
//  ViewController.swift
//  New_Assigment1
//
//  Created by Younoussa Ousmane Abdou on 12/20/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

var calculatorCount = 0

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorCount += 1
        print("Loaded up a new calculator, calculatorCount is: \(calculatorCount)")
        
        brain.changeMyDisplayTextColor(symbol: "E") { [weak weakme = self] in
            
            weakme?.display.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    deinit {
        
        calculatorCount -= 1
        print("Left the heap, calculatorCount is: \(calculatorCount)")
        
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        
        if userIsCurrentlyTypping {
            
            brain.setOperand(operand: displayValue)
            
            upperDisplay.text = brain.description
            display.text = brain.description
            
            userIsCurrentlyTypping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle {
            
            brain.performOperation(symbol: mathmaticalSymbol)
        }
        
        displayValue = brain.result
    }
    
    // A1 # 8
    @IBAction private func touchClear(sender: UIButton) {
        
        display.text = " "
        upperDisplay.text = " "
    }
    
    // A2 # 8
    @IBAction func setValue(sender: UIButton) {
        
        brain.variableValues["M"] = displayValue
        
        displayValue = brain.result
        
        print(displayValue)
    }
    
    @IBAction func notSetValue(sender: UIButton) {
        
        brain.setOperand(variableName: "M")
        displayValue = brain.result
        
        print(displayValue)
    }
    
    // A2 # 10 (Not completed)
    @IBAction func backBTNPressed(sender: UIButton) {
        
        //        if userIsCurrentlyTypping {
        //
        //
        //        } else {
        //
        //
        //        }
        //    }
    }
}
