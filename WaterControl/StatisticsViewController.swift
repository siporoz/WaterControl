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

class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,ChartProgressBarDelegate {

    
    @IBOutlet weak var chart: ChartProgressBar!
    
    // Data model: These strings will be the data for the table view cells
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    @IBOutlet var tableView: UITableView!
    
    
    let realm = try! Realm()
    var mainDate: String = ""
    
    // массив с кол-вом воды
    var arrCountWater : [String] = []
    // массив с литрами
    var arrLiterWater : [String] = []
    // Массив с датами
    var arrDate : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.blue
        
        mainDate = getDate()
        var countArr = 0
        let result = realm.objects(newData.self).filter("date = '\(mainDate)'")
        print(result.count)
        if(result.count != 0){
            for i in 0...result.count - 1 {               
                print(result[i].countWater)
                countArr = countArr + Int(result[i].countWater!)!
            }
        }

        // Добавляем даты в массив
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
//        // Массив с датами
//        var arrDate : [String] = []
        
        for itemDate in 0...7{
            let someDete = calendar.date(byAdding: .day, value: -itemDate, to: Date())
            formatter.dateFormat = "dd.MM.yyyy"
            let result1 = formatter.string(from: someDete!)
            arrDate.append(result1)
            print(result1)
        }
        
//        // массив с кол-вом воды
//        var arrCountWater : [String] = []
//        // массив с литрами
//        var arrLiterWater : [String] = []
        
        for itemCountWater in 0...7{
            
            var result = realm.objects(newData.self).filter("date = '\(arrDate[itemCountWater])'")
            var countWater = 0.0
            var countLiter = ""
            if(result.count != 0){
                for i in 0...result.count - 1{
                    print(result[i].countWater, "В Цикле '\(itemCountWater)'")
                    countWater = countWater + Double(Int(result[i].countWater!)!)
                    print(countWater, "ДАННЫЕ ")
                    countLiter = String(countWater / 1000.0)
                    print(countLiter, " В ЛИТРАХ ")
                }
                arrCountWater.append(String(countWater))
                arrLiterWater.append(countLiter)
            } else {
                arrCountWater.append(String("0"))
                arrLiterWater.append(String("0"))
                print("Добавил пустое заначения")
            }
        }
        
        var weightWater = loadData() ?? "0"
        var arrWeightWater : [Double] = []

        for barValueCount in 0...7{
            var finalCountWeight = 0.0
            var someCounter = Double(arrCountWater[barValueCount])
            if(someCounter! > Double(weightWater)!){
                finalCountWeight = 10.0
                arrWeightWater.append(finalCountWeight)
            } else {
                if(someCounter == 0){
                    arrWeightWater.append(0.0)
                } else {
                finalCountWeight = (someCounter! / Double(weightWater)!) * 10.0
                arrWeightWater.append(finalCountWeight)
                print(finalCountWeight, "финальное число")
                }
            }
        }
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        var data: [BarData] = []
        
        data.append(BarData.init(barTitle: arrDate[0], barValue: Float(arrWeightWater[0]), pinText: String(arrLiterWater[0])))
        data.append(BarData.init(barTitle: arrDate[1], barValue: Float(arrWeightWater[1]), pinText: String(arrLiterWater[1])))
        data.append(BarData.init(barTitle: "Mar", barValue: Float(arrWeightWater[2]), pinText: String(arrLiterWater[2])))
        data.append(BarData.init(barTitle: "Apr", barValue: Float(arrWeightWater[3]), pinText: String(arrLiterWater[3])))
        data.append(BarData.init(barTitle: "May", barValue: Float(arrWeightWater[4]), pinText: String(arrLiterWater[4])))
        data.append(BarData.init(barTitle: "Jun", barValue: Float(arrWeightWater[5]), pinText: String(arrLiterWater[5])))
        data.append(BarData.init(barTitle: "Jul", barValue: Float(arrWeightWater[6]), pinText: String(arrLiterWater[6])))
        
        chart.data = data
        chart.barsCanBeClick = true
        chart.maxValue = 10.0
        chart.emptyColor = UIColor.clear
        chart.barWidth = 7
        chart.progressColor = UIColor(hexString: "#492fef")
        chart.progressClickColor = UIColor(hexString: "#f2912c")
        chart.pinBackgroundColor = UIColor(hexString: "#e2335e")
        chart.pinTxtColor = UIColor(hexString: "#ffffff")
        chart.barTitleColor = UIColor(hexString: "#b6bdd5")
        chart.barTitleSelectedColor = UIColor(hexString: "#ffffff")
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
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        let monster = arrCountWater[indexPath.row]
        cell.textLabel?.text = arrDate[indexPath.row]
        cell.detailTextLabel?.text = animals[indexPath.row]
        let label = UILabel.init(frame: CGRect(x:0,y:0,width:60,height:20))
        label.text = arrLiterWater[indexPath.row]
        label.textColor = UIColor.gray
        cell.accessoryView = label

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    
    }



    
    
    
}

// Расширение для hex цветов
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


