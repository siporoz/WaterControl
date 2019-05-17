//
//  FastSettingsViewController.swift
//  WaterControl
//
//  Created by Владимир on 15.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit
import RealmSwift

class FastSettingsViewController: BottomPopupViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    
    @IBOutlet weak var test: UILabel!
    
    @IBOutlet weak var input: UITextField!
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty = true
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    let progress: String = ""
    
    let pickerViewValues = ["1000", "1100", "1200", "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000", "2100", "2200", "2300", "2400", "2500", "2600", "2700", "2800", "2900", "3000"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let string = pickerViewValues[row]
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        input.text = pickerViewValues[row]
    }
    
    var mainNumber = 0
    
    
    @IBAction func addButton(_ sender: UIButton) {

        let myVC = storyboard?.instantiateViewController(withIdentifier: "mainView") as! ViewController
        let singleton = Singletonn.shared
        let sdvj = Int(input.text!)
        singleton.weight = sdvj!
        mainNumber = sdvj!
        singleton.weight = mainNumber
        print(sdvj)
        //myVC.upDate()
        saveData()

        
        // dismiss(animated: true, completion: nil) КАК РЕАЛИЗОВТАЬ НОРМАЛЬНОЕ ЗАКРЫТИЕ?
        
    }
    
    func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    
    func saveData(){
        
        UserDefaults.standard.set(mainNumber, forKey: "weight")
        UserDefaults.standard.synchronize()
        
        
    }
    
    func loadData(){
        UserDefaults.standard.integer(forKey: "weight")
        mainNumber = UserDefaults.standard.integer(forKey: "weight")
    }
    
    
    
    
    override func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(300)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration ?? 1.0
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 1.0
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }

}
