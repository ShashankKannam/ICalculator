//
//  CalculatorLogic.swift
//  ICalculator
//
//  Created by shashank kannam on 8/7/17.
//  Copyright © 2017 developer. All rights reserved.
//

import Foundation

// Enum representing the supporting operations of the calculator

enum Operation {
    case addition
    case subtraction
    case multiplication
    case remainder
    case division
    case equals
    case changeSign
    case clear
}

class CalculatorLogic {
    
    var operand1: Double? // The first Operand
    var operand2: Double? // The second Operand
    var operationType: Operation? // The mathematical operation type
    
    //Dictionary which gives different operations in calculator
    
    var operations: [String: Operation] = [
        "✕"		: Operation.multiplication,
        "÷"		: Operation.division,
        "+"		: Operation.addition,
        "-"		: Operation.subtraction,
        "%"		: Operation.remainder,
        "+/-"	: Operation.changeSign,
        "="		: Operation.equals,
        "AC"    : Operation.clear
    ]
    
    // MARK: Perform Operations
    
    // Performs operations related to binary and clear all only
    
    func performBinaryOperation() -> String? {
        var result: Double?
        if let firstNumber = operand1, let secondNumber = operand2, let operationTypeIn = operationType {
            switch(operationTypeIn) {
                case .addition:
                    result = firstNumber + secondNumber
                case .subtraction:
                    result = firstNumber - secondNumber
                case .multiplication:
                    result = firstNumber * secondNumber
                case .division:
                    result = firstNumber / secondNumber
                case .remainder:
                    result = firstNumber.remainder(dividingBy: secondNumber)
                case .clear:
                    return clearAll()
                default:
                    break
            }
        }
        guard let value = result else { return nil }
        _ = clearAll()
        return String(describing: value)
    }
    
    // Performs operations related to changing sign, equals and clear all only
    
    func performUnaryOperation(operationType: Operation, changeSignForNumber number: Double?) -> String? {
        switch(operationType) {
            case .changeSign:
                guard var num = number  else { return nil }
                num *= -1
                return String(describing: num)
            case .equals:
                return performBinaryOperation()
            case .clear:
                return clearAll()
            default:
                break
        }
        return nil
    }
    
    // Clears all properties
    
    private func clearAll() -> String {
        operand1 = nil
        operand2 = nil
        operationType = nil
        return ""
    }
}
