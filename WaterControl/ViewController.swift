//
//  ViewController.swift
//  WaterControl
//
//  Created by Владимир on 10.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit
import UICircularProgressRing
import SPStorkController



class ViewController: UIViewController {

    @IBOutlet weak var progressWater: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    
    var myValue:String = "НИуя"

    
    var count = 3
    
    
    let button = UIButton.init(type: .system)
    @IBOutlet weak var some: UICircularProgressRing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRing()
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
        let singleton = Singletonn.shared
        //singleton.number = 3
        if(singleton.number == 0){
            singleton.number = 1
        }
        if(singleton.weight == 0){
            singleton.weight = 1
        }
        progressWater.text = String(singleton.number)
        weight.text = String(singleton.weight)
        upDate()
    }
    
    func upDate(){
        let count2 = Int(progressWater.text!) // Выпито
        let count = Int(weight.text!) // заданно
        
        
        let percent = count! / 100
        let final = Double(count2!) / Double(percent)
        some.value = CGFloat(final)

    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }   
    
    func addRing(){
        //some.value = 30
    }

    @IBAction func showViewControllerTapped(_ sender: UIButton) {
        guard let popupmain = storyboard?.instantiateViewController(withIdentifier: "main") as? PopUpViewController else { return }
        popupmain.height = screenHeight / 1.75
        popupmain.topCornerRadius = 20
        popupmain.presentDuration = 1.4
        popupmain.dismissDuration = 1.5
        
        present(popupmain, animated: true, completion: nil)
    }
    
    
    
    @IBAction func showFastSettings(_ sender: UIButton) {
        guard let popupmain = storyboard?.instantiateViewController(withIdentifier: "fastSettings ") as? FastSettingsViewController else { return }
        popupmain.height = screenHeight / 1.75
        popupmain.topCornerRadius = 20
        popupmain.presentDuration = 1.4
        popupmain.dismissDuration = 1.5
        
        present(popupmain, animated: true, completion: nil)
    }
    
    
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
}

