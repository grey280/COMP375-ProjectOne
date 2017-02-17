//
//  UnitConverterViewController.swift
//  ProjectOne
//
//  Created by Grey Patterson on 2017-02-17.
//  Copyright © 2017 Grey Patterson. All rights reserved.
//

import UIKit
import Foundation

class UnitConverterViewController: UIViewController {
    // Outlets
    @IBOutlet private weak var outputAmountL: UILabel!
    
    // Variables
    private var fromMetric = true // default to Metric->Imperial conversion
    private var fromUnit: UnitLength = .kilometers
    private var toUnit:UnitLength = .kilometers
    
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
    func doConversion(from: Measurement<UnitLength>, to: UnitLength) -> Measurement<UnitLength>{
        var outMeasure = Measurement(value: 0, unit:to)
        outMeasure = from.converted(to: to)
        return outMeasure
    }
    // IB Functions
    @IBAction private func editingDidEnd(_ sender: UITextField) {
        
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
