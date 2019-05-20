//
//  SettingsViewController.swift
//  WaterControl
//
//  Created by Владимир on 15.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var mainNumber = 0
    

    
    @IBOutlet weak var choose: UISegmentedControl!

    @IBOutlet weak var value: UITextField!

    let pickerViewValues = ["100", "200", "300", "400", "500", "600", "700", "800", "900", "1000"]

    var pickerData: [String] = [String]()
    var pickerData2: [String] = [String]()

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!



    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95", "100", "105", "110", "115", "120", "125", "130", "135", "140", "145", "150", "155", "160", "165", "170", "175", "180"]
        self.picker.delegate = self
        self.picker.dataSource = self

        pickerData2 = ["60", "65", "70", "75", "80", "85", "90", "95", "100", "105", "110", "115", "120", "125", "130", "135", "140", "145", "150", "155", "160", "165", "170", "175", "180", "185", "190", "195", "200", "205", "210", "215", "220", "225", "230"]
        self.picker2.delegate = self
        self.picker2.dataSource = self

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == picker {
            return pickerData.count
        } else {
            return pickerData2.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker {
            return pickerData[row]
        } else {
            return pickerData2[row]
        }
    }

    
    var plus = 0
    var weight = "1"
    var growth = "1"
    var chooser = "Мужской"

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        chooser = choose.titleForSegment(at: choose.selectedSegmentIndex)!
        print(chooser)
        
        if pickerView == picker {
        weight = pickerData[row]
        } else{
        growth = pickerData2[row]
        }
        if(chooser == "Мужской"){
        plus = Int(Double(weight)! * Double(growth)! * 0.15)
        } else {
            plus = Int(Double(weight)! * Double(growth)! * 0.1)
        }
        value.text = String(plus)
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "mainView") as! ViewController
        let singleton = Singletonn.shared
        let sdvj = Int(value.text!)
        singleton.weight = sdvj!
        mainNumber = sdvj!
        singleton.weight = mainNumber
        print(sdvj)
        //myVC.upDate()
        saveData()
    }
    
    func saveData(){
        UserDefaults.standard.set(mainNumber, forKey: "weight")
        UserDefaults.standard.synchronize()
    }
    
    
}
