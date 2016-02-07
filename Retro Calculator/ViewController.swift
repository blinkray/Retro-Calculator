//
//  ViewController.swift
//  Retro Calculator
//
//  Created by jim schuman on 2/7/16.
//  Copyright © 2016 RefactoredWeb. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        
        case Empty = "Empty"
    }
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound:AVAudioPlayer!
    
    var runningNumber: String = ""
    var leftVal:String = ""
    var rightVal: String = ""
    var currentOperation:Operation = Operation.Empty
    var result:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        outputLbl.text = ""
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }
        catch let err as NSError {
            print( err.debugDescription )
        }
    }
    
    @IBAction func clearEverything(sender: AnyObject) {
        runningNumber = ""
        leftVal = ""
        rightVal = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = ""
    }
    @IBAction func numberPressed( btn:UIButton ) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    func processOperation(op:Operation) {
        playSound()
        
        if( currentOperation != Operation.Empty ){
            
            if( runningNumber != "" ){
            
                rightVal = runningNumber
                runningNumber = ""
            
                if( currentOperation == Operation.Multiply ) {
                    result = "\(Double(leftVal)! * Double(rightVal)! )"
                }
                else if( currentOperation == Operation.Add ) {
                    result = "\(Double(leftVal)! + Double(rightVal)! )"
                }
                else if( currentOperation == Operation.Subtract ) {
                    result = "\(Double(leftVal)! - Double(rightVal)! )"
                }
                else if( currentOperation == Operation.Divide ) {
                    result = "\(Double(leftVal)! / Double(rightVal)! )"
                }
            
                leftVal = result
                outputLbl.text = result
            }
            currentOperation = op
                
            
        }
        else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if( btnSound.playing ){
            btnSound.stop()
        }
        // btnSound.play()
    }
}

