//
//  CalculatorViewController.swift
//  ICalculator
//
//  Created by shashank kannam on 8/7/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var displayLbl: UILabel!
    
    private var isUserInMiddleOfTyping = false // Whether user is in middle of typing
    
    lazy var calculatorLogic = CalculatorLogic() // Logic needed to perform calculation
    
    // Returns the current value displayed on the display Label
    var displayValue: Double? {
        if let value = displayLbl.text, !value.isEmpty {
            return Double(value)
        }
        return nil
    }
    
    // MARK: NumberPadTapped
 
    @IBAction func numberPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserInMiddleOfTyping {
            let textCurrentlyInDisplay = displayLbl.text!
            if (digit != ".") || (textCurrentlyInDisplay.range(of: ".") == nil) {
                displayLbl.text = textCurrentlyInDisplay + digit
            }
        } else {
            displayLbl.text = (digit == ".") ? "0." : digit
            isUserInMiddleOfTyping = true
        }
    }
    
    // MARK: OperationTapped
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard let operation = calculatorLogic.operations[(sender.titleLabel?.text!)!] else { return }
        if operation == Operation.changeSign || operation == Operation.clear {
            displayLbl.text = calculatorLogic.performUnaryOperation(operationType: operation, changeSignForNumber: displayValue)
        } else if operation != Operation.equals {
            getBothOperands()
            displayLbl.text = ""
            calculatorLogic.operationType = operation
        } else if operation == Operation.equals {
            getBothOperands()
        }
        calculate()
    }
    
    // MARK: Perform Operations
    
    // Assigns first and second operand values
    
    private func getBothOperands() {
        if let value = displayValue, calculatorLogic.operand1 == nil {
            calculatorLogic.operand1 = value
        } else if let value = displayValue, calculatorLogic.operand2 == nil {
            calculatorLogic.operand2 = value
        }
    }
    
    // Performs binary operation
    
    private func calculate() {
        if calculatorLogic.operand1 != nil && calculatorLogic.operand2 != nil {
            if let result = calculatorLogic.performBinaryOperation() {
                displayLbl.text = result
            }
        }
    }
    
}

