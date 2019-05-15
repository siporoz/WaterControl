//
//  PopUpViewController.swift
//  WaterControl
//
//  Created by Владимир on 12.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit

class PopUpViewController: BottomPopupViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    let pickerViewValues = ["100", "200", "300", "400", "500", "600", "700", "800", "900", "1000"]

    
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
        loadData()
        let myVC = storyboard?.instantiateViewController(withIdentifier: "mainView") as! ViewController
        let singleton = Singletonn.shared
        let sdvj = singleton.number + 32
        singleton.number = sdvj
        mainNumber = sdvj
        singleton.number = mainNumber
        print(sdvj)
        myVC.upDatet()
        saveData()
       // dismiss(animated: true, completion: nil)
        
    }
    
    
    func saveData(){
        
        UserDefaults.standard.set(mainNumber, forKey: "Progress")
        UserDefaults.standard.synchronize()
    
       
    }
    
    func loadData(){
        UserDefaults.standard.integer(forKey: "Progress")
        mainNumber = UserDefaults.standard.integer(forKey: "Progress")
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

