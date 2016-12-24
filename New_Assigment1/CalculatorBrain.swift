//
//  CalculatorBrain.swift
//  New_Assigment1
//
//  Created by Younoussa Ousmane Abdou on 12/20/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    // Success (6)
    var isPartialResult: Bool {
        
        if pending != nil {
            
            return false
        } else {
            
            return true
        }
    }
    
    var description: String {
        get {
            
            return "\(result)"
        }
    }
    
    private var accumulator = 0.0
    
    private var operations: [String: Operation] = [
        
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "log": Operation.UnaryOperation(log),
        "sin": Operation.UnaryOperation(sin),
        "cos": Operation.UnaryOperation(cos),
        "±": Operation.UnaryOperation({ number in -number }),
        "x²": Operation.UnaryOperation({ number in number * number}),
        "%": Operation.UnaryOperation({ number in number * 10 / 100 }),
        "×": Operation.BinaryOperation({ number1, number2 in number1 * number2 }),
        "÷": Operation.BinaryOperation({ number1, number2 in number1 / number2 }),
        "+": Operation.BinaryOperation({ number1, number2 in number1 + number2 }),
        "-": Operation.BinaryOperation({ number1, number2 in number1 - number2 }),
        ".": Operation.BinaryOperation({ number1, number2 in number1 + (number2 * 10 / 100) })
    ]
    
    private enum Operation {
        
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private struct PendingBinaryOperationInfo {
        
        var binaryOperation: ((Double, Double) -> Double)
        var firstOperand: (Double)
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private func executePendingBinaryOperation() {
        
        if pending != nil {
            
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            
            pending = nil
        }
    }
    
    var result: Double {
        get {
            
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        
        if let operation = operations[symbol] {
            
            switch operation {
            case .Constant(let value):
                accumulator = value
                
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
                
            case .BinaryOperation(let function):
                
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
                
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
}







