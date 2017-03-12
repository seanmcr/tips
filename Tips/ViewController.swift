//
//  ViewController.swift
//  Tips
//
//  Created by Sean McRoskey on 3/11/17.
//  Copyright © 2017 Sean McRoskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipSegmentationControl: UISegmentedControl!
    @IBOutlet weak var customTipTextField: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    var tipPercentage : Double = 15;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        
        billAmountTextField.becomeFirstResponder();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTipPercentageChanged(_ sender: AnyObject) {
        let isCustom = (tipSegmentationControl.selectedSegmentIndex == 3);
        if (isCustom){
            customTipTextField!.isHidden = false;
            customTipTextField!.isEnabled = true;
            customTipTextField.becomeFirstResponder();
        } else {
            customTipTextField!.isHidden = true;
            customTipTextField!.isEnabled = false;
        }
        updateTipPercentage();
    }
    
    @IBAction func onViewTapped(_ sender: AnyObject) {
        view.endEditing(true);
    }
    
    @IBAction func onBillAmountEditingChanged(_ sender: AnyObject) {
        updateTip();
    }
    
    @IBAction func onCustomTipPercentageEditingChanged(_ sender: AnyObject) {
        updateTipPercentage();
    }
    
    func updateTipPercentage(){
        let isCustom = (tipSegmentationControl.selectedSegmentIndex == 3);
        if (isCustom){
            tipPercentage = Double(customTipTextField.text!) ?? 0;
        } else {
            let tipPercentages = [15, 20, 25];
            tipPercentage = Double(tipPercentages[tipSegmentationControl.selectedSegmentIndex]);
        }
        updateTip();
    }
    func updateTip() {
        let billAmount = Double(billAmountTextField.text!) ?? 0;
        tipAmount.text = String.init(format: "$%.2f", arguments: [billAmount * (tipPercentage / 100.0)]);
        totalAmount.text = String.init(format: "$%.2f", arguments: [billAmount * (1 + (tipPercentage / 100.0))]);
        
    }
    

}

