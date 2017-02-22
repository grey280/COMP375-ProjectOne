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
    private var toUnit:UnitLength = .kilometers
    private var metricUnits = ["kilometers", "meters", "centimeters", "millimeters"]
    private var imperialUnits = ["inches", "feet", "miles"]
    
    
    // Complicated Variables
    var output: String{
        get{
            return outputAmountL.text!
        }
        set{
            // TODO: Handle actually setting the stuff here
            let outputString = "foo"
            
            outputAmountL.text = outputString
        }
    }
    
    // Helper Functions
    func convertUnit(from: Measurement<UnitLength>, to outputType: UnitLength) -> Measurement<UnitLength>{ // actually do the conversion
        return from.converted(to: outputType)
    }
    
    // IB Functions
    @IBAction private func editingDidEnd(_ sender: UITextField) { // User finished putting text into the input field
        
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){ // Respond to the user picking something.
        
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
