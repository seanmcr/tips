//
//  SettingsViewController.swift
//  Tips
//
//  Created by Sean McRoskey on 3/11/17.
//  Copyright © 2017 Sean McRoskey. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentageSegCtrl: UISegmentedControl!
    @IBOutlet weak var customTipStackView: UIStackView!
    @IBOutlet weak var customTipTextField: UITextField!
    
    var defaultTip : Int = 15;
    
    @IBAction func onDefaultTipValueChanged(_ sender: AnyObject) {
        let isCustom = (tipPercentageSegCtrl.selectedSegmentIndex == 3);
        customTipStackView.isHidden = !isCustom;
        customTipTextField.isEnabled = isCustom;
        if (isCustom){
            customTipTextField.becomeFirstResponder();
        }
        updateDefaultTip();
    }
    
    @IBAction func onCustomTipChanged(_ sender: AnyObject) {
        updateDefaultTip();
    }
    
    func updateDefaultTip(){
        let isCustom = (tipPercentageSegCtrl.selectedSegmentIndex == 3);
        if (isCustom){
            defaultTip = Int(customTipTextField.text!) ?? 0;
        }
        else{
            let percentages = [15, 20, 25];
            defaultTip = percentages[tipPercentageSegCtrl.selectedSegmentIndex]
        }
        
        let defaults = UserDefaults.standard;
        defaults.set(defaultTip, forKey: "defaultTip");
        defaults.synchronize();
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
                        tipPercentageSegCtrl.selectedSegmentIndex = i;
                        standard = true;
                        break;
                    }
                }
                
                if (!standard){
                    tipPercentageSegCtrl.selectedSegmentIndex = 3; // Custom
                    customTipTextField.text = "\(tip)";
                }
            }
            onDefaultTipValueChanged(NSNull());
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tryInitializeDefaultTip();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
