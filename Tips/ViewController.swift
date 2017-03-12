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
    
    static let tipPercentages : [Int] = [15, 20, 25];

    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        
        //tryInitializeDefaultTip()
        billAmountTextField.becomeFirstResponder();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        tryInitializeDefaultTip();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tryInitializeDefaultTip(){
        let defaults = UserDefaults.standard;
        let defaultTip = defaults.object(forKey: "defaultTip");
        if (defaultTip != nil){
            let tip = defaultTip as! Int;
            var standard = false;
            if (tip > 0){
                for i in 0 ..< ViewController.tipPercentages.count {
                    if (tip == ViewController.tipPercentages[i]){
                        tipSegmentationControl.selectedSegmentIndex = i;
                        standard = true;
                        break;
                    }
                }
                
                if (!standard){
                    tipSegmentationControl.selectedSegmentIndex = 3; // Custom
                    customTipTextField.text = "\(tip)";
                }
                
                onTipPercentageChanged(NSNull());
            }
        }
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
            tipPercentage = Double(ViewController.tipPercentages[tipSegmentationControl.selectedSegmentIndex]);
        }
        updateTip();
    }
    func updateTip() {
        let billAmount = Double(billAmountTextField.text!) ?? 0;
        tipAmount.text = String.init(format: "$%.2f", arguments: [billAmount * (tipPercentage / 100.0)]);
        totalAmount.text = String.init(format: "$%.2f", arguments: [billAmount * (1 + (tipPercentage / 100.0))]);
        
    }
    

}

