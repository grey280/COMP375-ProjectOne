//
//  TipCalculatorViewController.swift
//  ProjectOne
//
//  Created by Grey Patterson on 2017-02-15.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {
    
    func calculateTip(people: Int, amount: Double, tip: Double = 0.15) -> Double{
        let total = amount * tip
        return total / Double(people)
    }
    
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var tip: UILabel!
    @IBOutlet weak var perPerson: UILabel!
    
    var pointPressed = false, tenCent = false, hundredCent = false
    var costD: Double { // an easier way to access the value of the cost as a double
        get{ // Double() can't deal with the $ in there, so strip it out and *then* cast
            let costString = cost.text!
            let ind = costString.index(costString.startIndex, offsetBy: 1)
            let outString = costString.substring(from: ind)
            return Double(outString)!
        }
        set{ // this part is easy, just cast to string and add the $
            let outString = "$" + String(newValue)
            cost.text = outString
        }
    }
    
    @IBAction func digitPress(_ sender: UIButton) { // handle a digit press
        let digitPressed = Double(sender.title(for: .normal)!)!
        if costD == 0 && !pointPressed{
            costD = digitPressed
        } else if !pointPressed {
            costD = costD * 10
            costD += digitPressed
        } else if !tenCent { // we don't have a ten cent column yet, add that
            costD = costD + 0.1 * digitPressed
            tenCent = true
        } else if !hundredCent{ // we don't have a cent column yet, add that
            costD = costD + 0.01 * digitPressed
            hundredCent = true
        } else{
            // do nothing
        }
    }
    
    @IBAction func deletePress(_ sender: UIButton) { // reset the cost to zero
        costD = 0.0
        pointPressed = false
        tenCent = false
        hundredCent = false
    }
    
    @IBAction func pointPress(_ sender: UIButton) { // press the decimal point! oh, this is gonna be fun
        pointPressed = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
