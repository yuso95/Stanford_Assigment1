//
//  CalculatorBrain.swift
//  New_Assigment1
//
//  Created by Younoussa Ousmane Abdou on 12/20/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    // Assignment 2
    typealias PropertyList = AnyObject
    
    // Assignment 2
    private var internalProgram = [AnyObject]()
    private var symbolDescription: String?
    
    // A1 # 6
    var isPartialResult: Bool {
        
        if pending != nil {
            
            return false
        } else {
            
            return true
        }
    }
    
    var description: String {
        get {
            
            var description = "\(accumulator)"
            
            if pending != nil {
                
                if let safeSymbol = symbolDescription {
                    
                    description += "\(safeSymbol)"
                                        
                    if variableValues["M"] == 0 {
                        
                        description += "M"
                    } else {
                        
                        description += "M"
                    }
                }
                
            }
            
            return description
        }
    }
    
    func changeMyDisplayTextColor(symbol: String, operation: @escaping (Double) -> Double) { // I wasn't expecting @esaping
        
        operations[symbol] = Operation.UnaryOperation(operation)
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
        ".": Operation.BinaryOperation({ number1, number2 in number1 + (number2 * 10 / 100) }),
        "=": Operation.Equals
    ]
    
    // A2 # 4
    var variableValues: Dictionary<String, Double> = [
        
        "M": 0.0
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
            
            if let value = variableValues["M"], value == 0.0 {
                
                accumulator += value
            }
            
            return accumulator
        }
    }
    
    // Assignment 2
    var program: PropertyList {
        get {
            
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            
            clear()
            
            if let arrayOfObj = newValue as? [AnyObject] {
                
                for obj in arrayOfObj {
                    
                    if let operand = obj as? Double {
                        
                        setOperand(operand: operand)
                    } else if let operation = obj as? String {
                        
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    private func clear() {
        
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    func setOperand(operand: Double) {
        
        accumulator = operand
        
        internalProgram.append(operand as AnyObject)
    }
    
    // A2 #2
    func setOperand(variableName: String) {
        
        if let value = variableValues["M"] {
            
            accumulator = value
        }
        
        // A2 #7
        internalProgram.append(variableName as AnyObject)
    }
    
    func performOperation(symbol: String) {
        
        internalProgram.append(symbol as AnyObject)
        
        symbolDescription = symbol
        
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






