//
//  UnitConverterViewController.swift
//  ProjectOne
//
//  Created by Grey Patterson on 2017-02-17.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import Foundation

class UnitConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // Outlets
    @IBOutlet private weak var outputAmountL: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var leftPicker: UIPickerView!
    @IBOutlet weak var rightPicker: UIPickerView!
    
    // Variables
    private var fromMetric = true // default to Metric->Imperial conversion
    private var fromUnit:UnitLength = .kilometers
    private var toUnit:UnitLength = .inches
    private let metricUnits = ["kilometers", "meters", "centimeters", "millimeters"]
    private let imperialUnits = ["inches", "feet", "miles"]
    private let unitsToFoundationUnits:[String: UnitLength] = ["kilometers": .kilometers, "meters": .meters, "centimeters": .centimeters, "millimeters": .millimeters, "inches": .inches, "feet": .feet, "miles": .miles]
    private let foundationUnitsToUnits:[UnitLength: String] = [.kilometers: "kilometers", .meters: "meters", .centimeters: "centimeters", .millimeters: "millimeters", .inches: "inches", .feet: "feet", .miles: "miles"]
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
    func convertUnit(from: Measurement<UnitLength>, to outputType: UnitLength) -> Measurement<UnitLength>{ // actually do the conversion
        return from.converted(to: outputType)
    }
    func doUpdate(){ // Does the conversion and stuff
        let outputAmount = Measurement(value: inputAmount, unit: fromUnit) // TODO: make tempVar be the input amount
        let outputString = convertUnit(from: outputAmount, to: toUnit)
        let outStringValue = String.localizedStringWithFormat("%.2f", outputString.value)
        let outStringUnit = foundationUnitsToUnits[outputString.unit]!
        output = "\(outStringValue) \(outStringUnit)"
    }
    
    // IB Functions
    @IBAction private func editingDidEnd(_ sender: UITextField) { // User finished putting text into the input field
        inputAmount = Double(sender.text!) ?? 0.0
        doUpdate()
    }
    @IBAction func switchUnits(_ sender: UIButton) {
        fromMetric = !fromMetric
        leftPicker.reloadComponent(0)
        rightPicker.reloadComponent(0)
    }
    
    
    // Here's where all the UIPickerView stuff comes in
    func numberOfComponents(in: UIPickerView)->Int{ // How many columns? Only 1.
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int)->Int{ // how many rows in the picker?
        if pickerView == leftPicker{
            if fromMetric{
                return metricUnits.count
            }
            return imperialUnits.count
        }else{
            if fromMetric{
                return imperialUnits.count
            }
            return metricUnits.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{ // Gets a String? to fill each spot in the picker. Since it's only got one component, we ignore that. Figuring out which picker to go with and how to return the thing is slightly more interesting.
        if pickerView == leftPicker{
            if fromMetric{
                return metricUnits[row]
            }
            return imperialUnits[row]
        }else{
            if fromMetric{
                return imperialUnits[row]
            }
            return metricUnits[row]
        }
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputField.becomeFirstResponder()
        leftPicker.delegate = self
        rightPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
