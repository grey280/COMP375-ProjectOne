//
//  UnitConverterViewController.swift
//  ProjectOne
//
//  Created by Grey Patterson on 2017-02-17.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import Foundation

class UnitConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    // Outlets
    @IBOutlet private weak var outputAmountL: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    
    // Variables
    private var fromMetric = true // default to Metric->Imperial conversion
    private var fromUnit:UnitLength = .kilometers // defaults Kilometers -> Kilometers. Sensical!
    private var toUnit:UnitLength = .kilometers
    // All the units we can use. If adding, amke sure to update the dictionaries as well!
    private let units = ["kilometers", "meters", "centimeters", "millimeters", "inches", "feet", "yards", "miles"]
    // Dictionaries so we can have nice conversion from UnitLength to String and back
    private let unitsToFoundationUnits:[String: UnitLength] = ["kilometers": .kilometers, "meters": .meters, "centimeters": .centimeters, "millimeters": .millimeters, "inches": .inches, "feet": .feet, "miles": .miles, "yards": .yards]
    private let foundationUnitsToUnits:[UnitLength: String] = [.kilometers: "kilometers", .meters: "meters", .centimeters: "centimeters", .millimeters: "millimeters", .inches: "inches", .feet: "feet", .miles: "miles", .yards: "yards"]
    // An easy way to store the input amount
    private var inputAmount = 0.0
    
    
    // Complicated Variables
    var output: String{ // Just a slightly easier interface
        get{
            return outputAmountL.text!
        }
        set{
            outputAmountL.text = newValue
        }
    }
    
    // Helper Functions
    private func convertUnit(from: Measurement<UnitLength>, to outputType: UnitLength) -> Measurement<UnitLength>{ // actually do the conversion
        return from.converted(to: outputType)
    }
    private func doUpdate(){ // Does the conversion and stuff
        let outputAmount = Measurement(value: inputAmount, unit: fromUnit)
        let outputString = convertUnit(from: outputAmount, to: toUnit)
        // let outStringValue = String.localizedStringWithFormat("%.4f", outputString.value)
        let outStringValue = String(roundTo(input: outputString.value, places: 4))
        let outStringUnit = foundationUnitsToUnits[outputString.unit]!
        
        output = "\(outStringValue) \(outStringUnit)"
    }
    private func roundTo(input: Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (input * divisor).rounded() / divisor
    }
    
    // IB Functions
    @IBAction private func editingDidEnd(_ sender: UITextField) { // Used to detect input happening. Fires *after* the UITextField delegate stuff below
        inputAmount = Double(sender.text!) ?? 0.0
        doUpdate()
    }
    
    
    // UIPickerView delegate stuff
    func numberOfComponents(in: UIPickerView)->Int{ // How many columns? Only 1.
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int)->Int{ // how many rows in the picker?
        return units.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{ // Get the unit name
        return units[row]
    }
    func pickerView(_ pickerViewUsed: UIPickerView, didSelectRow row: Int, inComponent component: Int){ // Respond to the user picking something.
        let unitSelected = pickerView(pickerViewUsed, titleForRow: row, forComponent: component)!
        let foundationUnitSelected = unitsToFoundationUnits[unitSelected]!
        if pickerViewUsed == leftPicker{
            fromUnit = foundationUnitSelected
        }else{
            toUnit = foundationUnitSelected
        }
        doUpdate()
    }
    
    // UITextField delegate stuff
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // Only allow numbers and decimal point - iPad doesn't have a digit-only keyboard.
        
        let set = NSCharacterSet(charactersIn: "0123456789.")
        let inverted = set.inverted;
        
        let filtered = string.components(separatedBy: inverted).joined(separator: "")
        return filtered == string;
        // Note: can't do the doUpdate() stuff in here, because detecting the actual contents of the textField doesn't work right in here - this event fires *before* it updates, so you'd have to manually figure out the new value. Easier to leave in the IBAction up above.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Attach our delegates:
        leftPicker.delegate = self
        rightPicker.delegate = self
        inputField.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputField.becomeFirstResponder() // Pull up the keyboard for the user
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
