//
//  ViewController.swift
//  CalculatorApp
//
//  Created by BZN8  on 21/01/2018.
//  Copyright © 2018 BZN8. All rights reserved.
//

import UIKit
import AVFoundation

enum Operation:String {
    
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Nil = "Nil"
}

class ViewController: UIViewController {
  
    @IBOutlet weak var label: UILabel!
    
    var currentNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .Nil
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "0"
        
        let clickSound = Bundle.main.path(forResource: "btnSound", ofType: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: clickSound! ))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            print(error)
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if currentNumber.count <= 8 {
    currentNumber += "\(sender.tag)"
        label.text = currentNumber
        }
        player.play()
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        currentNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .Nil
        label.text = "0"
        player.play()
    }
   
    @IBAction func devidePressed(_ sender: UIButton) {
        operation(operation: .Divide)
        player.play()
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        operation(operation: .Subtract)
        player.play()
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        operation(operation: .Add)
        player.play()
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        operation(operation: currentOperation)
        player.play()
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if currentNumber.count <= 7 {
        currentNumber += "."
        label.text = currentNumber
        player.play()
        }
    }
    
    func operation(operation: Operation) {
        if currentOperation != .Nil{
            if currentNumber != ""{
                rightValue = currentNumber
                currentNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }else if currentOperation == .Subtract{
                     result = "\(Double(leftValue)! - Double(rightValue)!)"
                }else if currentOperation == .Multiply{
                     result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if currentOperation == .Divide{
                     result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                label.text = result
            }
            currentOperation = operation
            
        }else{
            leftValue = currentNumber
            currentNumber = ""
            currentOperation = operation
        }
        
    }
    
    
}

