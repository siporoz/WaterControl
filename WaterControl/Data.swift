//
//  Data.swift
//  WaterControl
//
//  Created by Владимир on 15.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import Foundation
import RealmSwift

class Singletonn {
    
    static let shared = Singletonn()
    var number = UserDefaults.standard.integer(forKey: "Progress") 
    
    var weight = UserDefaults.standard.integer(forKey: "weight")
    
    
    var fjdsijf = UserDefaults.standard.integer(forKey: "weigfdsfht")
    
    // тестируем со временем
    
 //   var numberTime:[String: String] = UserDefaults.standard.dictionary(forKey: "numberTime") as! [String : String]
    
    var mainDate = UserDefaults.standard.string(forKey: "Date")
    
    var arrDate = UserDefaults.standard.array(forKey: "arrData")
}
