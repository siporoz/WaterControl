//
//  StatisticsViewController.swift
//  WaterControl
//
//  Created by Владимир on 17.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit
import ChartProgressBar
import RealmSwift

class StatisticsViewController: UIViewController, ChartProgressBarDelegate {
    @IBOutlet weak var chart: ChartProgressBar!
    
    
    let realm = try! Realm()
    var mainDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        // Добавляем даты в массив
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        // Массив с датами
        var arrDate : [String] = []
        
        for itemDate in 1...7{
            let someDete = calendar.date(byAdding: .day, value: -itemDate, to: Date())
            formatter.dateFormat = "dd.MM.yyyy"
            let result1 = formatter.string(from: someDete!)
            arrDate.append(result1)
            print(result1)
        }
        
        
        var arrCountWater : [String] = []
        
        for itemCountWater in 1...6{
            var countWater = 0.0
            let result = realm.objects(newData.self).filter("date = '\(arrDate[itemCountWater])'")
            if(result.count != 0){
                for i in 0...result.count - 1{
                    print(result[i].countWater)
                    countWater = countWater + Double(Int(result[i].countWater!)!)
                    arrCountWater.append(String(countWater))
                    print(countWater, "ДАННЫЕ ")
                }
            }
        }
        
        var weightWater = loadData()
        var arrWeightWater : [Double] = []

        for barValueCount in 0...6{
            var finalCountWeight = 0.0
            var someCounter = Double(arrCountWater[barValueCount])
            if(someCounter! > Double(weightWater!)!){
                finalCountWeight = 10.0
                arrWeightWater.append(finalCountWeight)
            } else {
                finalCountWeight = (someCounter! / Double(weightWater!)!) * 10.0
                arrWeightWater.append(finalCountWeight)
                print(finalCountWeight, "финальное число")
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        var data: [BarData] = []
        
        data.append(BarData.init(barTitle: arrDate[0], barValue: Float(arrWeightWater[0]), pinText: "1.4 €"))
        data.append(BarData.init(barTitle: arrDate[1], barValue: 10, pinText: "10 €"))
        data.append(BarData.init(barTitle: "Mar", barValue: 3.1, pinText: "3.1 €"))
        data.append(BarData.init(barTitle: "Apr", barValue: 4.8, pinText: "4.8 €"))
        data.append(BarData.init(barTitle: "May", barValue: 6.6, pinText: "6.6 €"))
        data.append(BarData.init(barTitle: "Jun", barValue: 7.4, pinText: "7.4 €"))
        data.append(BarData.init(barTitle: "Jul", barValue: 5.5, pinText: "5.5 €"))
        
        chart.data = data
        chart.barsCanBeClick = true
        chart.maxValue = 10.0
        chart.emptyColor = UIColor.clear
        chart.barWidth = 7
        chart.progressColor = UIColor.red
//        chart.progressColor = UIColor.init(hexString: "99ffffff")
//        chart.progressClickColor = UIColor.init(hexString: "F2912C")
//        chart.pinBackgroundColor = UIColor.init(hexString: "E2335E")
//        chart.pinTxtColor = UIColor.init(hexString: "ffffff")
//        chart.barTitleColor = UIColor.init(hexString: "B6BDD5")
//        chart.barTitleSelectedColor = UIColor.init(hexString: "FFFFFF")
        chart.pinMarginBottom = 15
        chart.pinWidth = 70
        chart.pinHeight = 29
        chart.pinTxtSize = 17
        chart.delegate = self
        chart.build()
        
        chart.disableBar(at: 3)
        
        let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chart.enableBar(at: 3)
        }
    }
    
    
    func ChartProgressBar(_ chartProgressBar: ChartProgressBar, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }
    
    // applicationDidBecomeActive
    @objc func applicationDidBecomeActive(notification: NSNotification) {
            self.viewDidLoad()
    }
    
    
    func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    func loadData() -> String?{
        let mainNumber = UserDefaults.standard.string(forKey: "weight")
        return mainNumber
    }
}

