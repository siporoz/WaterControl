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
import RealmSwift


class ViewController: UIViewController{
    
    let realm = try! Realm()

    @IBOutlet weak var progressWater: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    func applicationWillResignActive(_ application: UIApplication){
        print("Пздц")
    }
    
    var myValue:String = ""

    
    var count = 3
    var mainDate: String = ""
    
    let button = UIButton.init(type: .system)
    @IBOutlet weak var some: UICircularProgressRing!
    
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        // Кол-во воды
        weight.text = loadData()
        
        let realm = try! Realm()
        
        
        // applicationDidBecomeActive
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        // Ring
        addRing()
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
       
        // Get date
        mainDate = getDate()
        var countArr = 0
        let result = realm.objects(newData.self).filter("date = '\(mainDate)'")
        print(result.count)
        if(result.count != 0){
        for i in 0...result.count - 1{
            print(result[i].countWater)
            countArr = countArr + Int(result[i].countWater!)!
        }
        }
        progressWater.text = String(countArr)
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
    
    func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    
    // applicationDidBecomeActive
    @objc func applicationDidBecomeActive(notification: NSNotification) {
        // Application is back in the foreground
        let mainDate = getDate()
        let loadDate = loadData()
        print(mainDate," СЕГОДНЯШНЯЯ ДАТА ")
        print(loadDate!," ПОДГРУЖЕННАЯ ДАТА ")
        
        if(mainDate != loadDate!){
            self.viewDidLoad()
        }
    }
    
    
    func loadData() -> String?{
        let mainNumber = UserDefaults.standard.string(forKey: "weight")
        return mainNumber
    }
    
}

