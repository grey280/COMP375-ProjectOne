//
//  TipCalculatorViewController.swift
//  ProjectOne
//
//  Created by Grey Patterson on 2017-02-15.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {
    
    private func calculatePerPerson(people: Int, amount: Double, tip: Double = 0.15) -> Double{
        let total = amount * tip
        return total / Double(people)
    }
    
    @IBOutlet private weak var cost: UILabel!
    @IBOutlet private weak var tip: UILabel!
    @IBOutlet private weak var perPerson: UILabel!
    @IBOutlet private weak var pointButton: UIButton!
    
    private var pointPressed = false, tenCent = false, hundredCent = false
    
    private func stringToDouble(input: String) -> Double{ // let's make this into a function, for reuse
        let ind = input.index(input.startIndex, offsetBy: 1)
        let outString = input.substring(from: ind)
        return Double(outString)!
    }
    
    var costD: Double { // an easier way to access the value of the cost as a double
        get{ // get the cost string - assume it's there since I'm always doing it properly
            let costString = cost.text!
            return stringToDouble(input: costString)
        }
        set{ // this part is easy, just cast to string and add the $
            let outString = String.localizedStringWithFormat("$%.2f", newValue)
            cost.text = outString
            
            // and now our didSet-type bit: when cost changes, recalculate tip:
            tipD = newValue * 0.15
            // plus, calculate the per-person value:
            perPersonD = (newValue + tipD)/Double(peopleCount)
        }
    }
    var tipD: Double { // an easier way to access the value of the tip as a double; copied from above
        get{ // again, using the function to do the conversion
            let tipString = tip.text!
            return stringToDouble(input: tipString)
        }
        set{ // make it in the format $0.00 - only two digits after the decimal!
            let outString = String.localizedStringWithFormat("$%.2f", newValue)
            tip.text = outString
        }
    }
    var perPersonD: Double { // an easier way to access the value of the tip as a double; copied from above
        get{ // again, using the function to do the conversion
            let ppdString = perPerson.text!
            return stringToDouble(input: ppdString)
        }
        set{
            let outString = String.localizedStringWithFormat("$%.2f", newValue)
            perPerson.text = outString
        }
    }
    var peopleCount: Int {
        get{ // TODO: actually get this number, probably from a private variable? or replace or w/e
            return 1 // don't leave it as 0, then the per-person cost is INFINITY
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
        pointButton.isEnabled = true
    }
    
    
    @IBAction func pointPress(_ sender: UIButton) { // press the decimal point! oh, this is gonna be fun
        pointPressed = true
        pointButton.isEnabled = false
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
