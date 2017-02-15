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
    
    @IBAction func digitPress(_ sender: UIButton) {
    }
    
    @IBAction func deletePress(_ sender: UIButton) {
    }
    
    @IBAction func pointPress(_ sender: UIButton) {
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
